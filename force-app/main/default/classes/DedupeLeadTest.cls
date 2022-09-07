//Created on 2022.07.13

@isTest
public class DedupeLeadTest {

        //Negative test case
        @isTest static void createLeadNoDupes() {
            String leadOwner = UserInfo.getUserId();

            // Create all required records
            Lead myLead = new Lead();
            myLead.FirstName   = 'First';
            myLead.LastName    = 'Last';
            myLead.Email       = 'email@mail.com';
            myLead.Company     = 'Company';
            myLead.Description = 'Description';
            myLead.OwnerId     = leadOwner;
            insert myLead;
            
            // Use SOQL to find the latest values
            Lead updatedLead = [SELECT OwnerId,
                                       Description
                                  FROM Lead
                                 WHERE Id = :myLead.Id];

            // Assert that results are as expected
            System.assertEquals(leadOwner, updatedLead.OwnerId);
            System.assertEquals(myLead.Description, updatedLead.Description);
        }

        @isTest static void createLeadMultipleDupes() {
            String email = 'email@mail.com';

            //Create two dupe contacts
            List<Contact> dupeContacts = new List<Contact>();
            Contact firstDupe = new Contact();
            firstDupe.FirstName   = 'First';
            firstDupe.LastName    = 'Last';
            firstDupe.Email       =  email;
            dupeContacts.add(firstDupe);

            Contact secondDupe = new Contact();
            secondDupe.FirstName   = 'First';
            secondDupe.LastName    = 'Last';
            secondDupe.Email       = email;
            dupeContacts.add(secondDupe);       
            insert dupeContacts;

            //Create our dupe lead
            Lead myLead = new Lead();
            myLead.FirstName   = 'First';
            myLead.LastName    = 'Last';
            myLead.Email       = 'email@mail.com';
            myLead.Company     = 'Company';
            myLead.Description = 'Description';
            myLead.OwnerId     = UserInfo.getUserId();
            insert myLead;            

            // Use SOQL to find the latest values of our lead
            Lead updatedLead = [SELECT OwnerId,
                                       Description
                                  FROM Lead
                                 WHERE Id = :myLead.Id];

            //Get the data quality queue info
            Group dataQualityQueue = [SELECT Id
                                        FROM Group
                                       WHERE DeveloperName = 'Data_Quality'
                                       LIMIT 1];

            System.assertEquals(dataQualityQueue.Id, updatedLead.OwnerId);
            System.assert(updatedLead.Description.contains(firstDupe.Id));
            System.assert(updatedLead.Description.contains(secondDupe.Id));
        }
}