//Created on 2022.07.11

trigger DedupeLead on Lead (before insert) {
    //Get the data quality queue record ready for future use
    List<Group> dataQualityGroups = [SELECT Id
                                       FROM Group
                                      WHERE DeveloperName = 'Data_Quality'
                                      LIMIT 1];
    for (Lead myLead: Trigger.new) {
        if (myLead.Email != null) {

            //Searching for matching contact(s)
            List<Contact> matchingContacts = [SELECT Id,
                                                     FirstName,
                                                     LastName,
                                                     Account.Name
                                                FROM Contact
                                               WHERE Email = :myLead.Email];
            System.debug(matchingContacts.size() + ' contact(s) found.');                                    

            //If a matches are found
            if (!matchingContacts.isEmpty()) {
                //Assign the lead to the data quality queue
                if(!dataQualityGroups.isEmpty()) {
                    myLead.OwnerId = dataQualityGroups.get(0).Id;
                }

                //Add the dupe contact IDs into the lead description
                String dupeContactsMessage = 'Duplicate contact(s) found:\n';
                for (Contact matchingContact : matchingContacts) {
                    dupeContactsMessage += matchingContact.FirstName + ' '
                                        + matchingContact.LastName + ', '
                                        + matchingContact.Account.Name + ' '
                                        + matchingContact.Id + '\n';
                }
                if (myLead.Description != null) {
                    dupeContactsMessage += '\n' + myLead.Description;
                }
                myLead.Description = dupeContactsMessage;
            }
        }
    }
}