public class GenericRollupSummary {
    public static void calculateRollup(String parentApiName, String childApiName, String parentFieldApiName) {
        // Query to count child records for each parent
        String query = 'SELECT ' + parentFieldApiName + ', count(Id) count FROM ' + childApiName + ' GROUP BY ' + parentFieldApiName;
        List<SObject> results = Database.query(query);

        // Map to hold parent record Ids and their corresponding child record count
        Map<Id, Integer> parentChildCount = new Map<Id, Integer>();
        for (SObject result : results) {
            parentChildCount.put((Id)result.get(parentFieldApiName), (Integer)result.get('count'));
        }

        // Update parent records with the count of child records
        List<SObject> parentsToUpdate = new List<SObject>();
        for (Id parentId : parentChildCount.keySet()) {
            SObject parent = Schema.getGlobalDescribe().get(parentApiName).newSObject(parentId);
            parent.put('NumberOfChildren__c', parentChildCount.get(parentId));
            parentsToUpdate.add(parent);
        }
        update parentsToUpdate;
    }
}