//Created on 2022.07.18

trigger UpdateContactPhone on Account (before update) {
    for (Account acc : Trigger.new) {
        //Make sure the phone number is populated
        if (acc.Phone != null) {
            List<Contact> consToUpdate = [SELECT Id,
                                                 MailingCountry
                                            FROM Contact
                                           WHERE AccountId = :acc.Id];
        
            if (!consToUpdate.isEmpty()) {
                for (Contact con : consToUpdate) {
                    if (con.MailingCountry != null && con.MailingCountry == acc.BillingCountry) {
                        con.OtherPhone = acc.Phone;
                    }
                }
                update consToUpdate;
            }
        }
    }
}