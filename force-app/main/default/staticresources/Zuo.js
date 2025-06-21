var ProductSelectorPlugin = function(){
    return {
        postRecalculateZCharge : function(previousZCharge,
            currentZCharge, chargeGroup, quote, allChargeGroups) {
            alert('Overriding List Price to 1000!!!!');
            currentZCharge['LIST_PRICE'] = '1000.00';
            zquGlobalPlugin.updateZCharge(currentZCharge);
        }
    };
}();
