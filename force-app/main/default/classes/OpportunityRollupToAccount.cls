public class OpportunityRollupToAccount {
    public static void rollupAmounts() {
        Map<Id, Account> accountMap = new Map<Id, Account>();
        List<Opportunity> opps = [SELECT Id, Amount, AccountId FROM Opportunity WHERE AccountId != NULL];
        for (Opportunity opp : opps) {
            if (!accountMap.containsKey(opp.AccountId)) {
                accountMap.put(opp.AccountId, new Account(Id = opp.AccountId, Description = ''));
            }
            Account acc = accountMap.get(opp.AccountId);
            acc.Description += 'Total Opportunity Amount: ' + String.valueOf(opp.Amount) + '\n';
        }
        update accountMap.values();
    }
}