//Created on 2022.07.02
trigger WarrantySummary on Case (before insert) {

    String endingStatement = 'Have a nice day!';
    
    for (Case myCase : Trigger.new) {
        //Set up variables to use in the summary field
        if (myCase.Product_Purchase_Date__c != null
            && myCase.Product_Total_Warranty_Days__c != null
            && myCase.Product_Has_Extended_Warranty__c != null) {
            String purchaseDate         = myCase.Product_Purchase_Date__c.format();
            String createdDate          = DateTime.now().format();
            Integer warrantyDays        = myCase.Product_Total_Warranty_Days__c.IntValue();
            Decimal warrantyPercentage  = (100 * (myCase.Product_Purchase_Date__c.daysBetween(Date.today()) 
                                           / myCase.Product_Total_Warranty_Days__c)).setScale(2);
            Boolean hasExtendedWarranty = myCase.Product_Has_Extended_Warranty__c;

            //Populate summary field
            myCase.Warranty_Summary__c  = 'Product purchased on ' + purchaseDate + ' '
                                          + 'and Case created on ' + createdDate + '.\n'
                                          + 'Warranty is for ' + warrantyDays + ' '
                                          + 'and is ' + warrantyPercentage + '% through its warranty period.\n'
                                          + 'Extended warranty: ' + hasExtendedWarranty + '\n'
                                          + endingStatement;
        }
    }
}