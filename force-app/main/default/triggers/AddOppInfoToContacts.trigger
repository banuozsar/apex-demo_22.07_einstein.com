//Created on 2022.07.19

trigger AddOppInfoToContacts on Opportunity (after insert) {
    for(Opportunity opp : Trigger.new) {
        if(opp.AccountId != null) {
            //Get all contacts to be updated
            List<Contact> cons = [SELECT Id,
                                         Description
                                    FROM Contact
                                   WHERE AccountId = :opp.AccountId];
            
            //Get opp creator info
            User oppCreator = [SELECT Name
                                 FROM User
                                WHERE Id = :opp.CreatedById];

            String oppInfo = 'New opportunity is created by '
                             + oppCreator.Name + ' with close date '
                             + String.valueOf(opp.CloseDate) + '.';
            
            if(!cons.isEmpty()) {
                for (Contact con : cons) {
                    String newContactDesc = oppInfo;
                    //Add the existing contact desc to the end if it exists
                    if(con.Description != null) {
                        newContactDesc += '\n\n' + con.Description;
                    }
                    con.Description = newContactDesc;
                }
                update cons;
            }
        }
    }
}