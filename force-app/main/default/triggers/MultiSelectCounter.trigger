//Created on 2022.07.10
trigger MultiSelectCounter on Account (before insert, before update) {
    for (Account acc : Trigger.new) {
        if (acc.MPS__c != null) {
            //Update the MPS_Counter if our MPS field has items
            Integer count      = acc.MPS__c.countMatches(';') + 1;
            acc.MSP_Counter__c = count;
            System.debug('Number of items found for '+ acc.Name + ': ' + count);
        } else {
            //Reset the MPS_Counter if our MPS field has no items
            acc.MSP_Counter__c = 0;
            System.debug('No items found for '+ acc.Name);
        }        
    }
}