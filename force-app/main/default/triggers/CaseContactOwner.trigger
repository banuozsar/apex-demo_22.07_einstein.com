//Created on 2022.07.17

trigger CaseContactOwner on Case (after insert) {
    for (Case myCase : Trigger.new) {

        //Make sure there's a contact for null pointer exceptions
        if (myCase.ContactId != null) {
            
            //Find the contact for updating
            Contact con = [SELECT Id
                            FROM Contact
                            WHERE Id = :myCase.ContactId];
            
            //Update the contact - needs DML 
            con.OwnerId = myCase.CreatedById;
            update con;
        }
        if (myCase.AccountId != null) {
            
            //Find the contact for updating
            Account acc = [SELECT Id
                            FROM Account
                            WHERE Id = :myCase.AccountId];
            
            //Update the contact - needs DML 
            acc.OwnerId = myCase.CreatedById;
            update acc;
        }             
    }
}