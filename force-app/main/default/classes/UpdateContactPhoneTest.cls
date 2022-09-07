//Created on 2022.07.18

@isTest
public class UpdateContactPhoneTest {
    @istest static void updatePhoneOnAccount() {
        String country ='US';

        //Create records
        Account acc        = new Account();
        acc.Name           = 'acc';
        acc.BillingCountry = country;
        insert acc;

        List<Contact> cons = new List<Contact>();

        Contact conSameCountry        = new Contact();
        conSameCountry.AccountId      = acc.Id;
        conSameCountry.LastName       = 'contact';
        conSameCountry.MailingCountry = country;
        cons.add(conSameCountry);

        Contact conDiffCountry        = new Contact();
        conDiffCountry.AccountId      = acc.Id;
        conDiffCountry.LastName       = 'Acontact';
        conDiffCountry.MailingCountry = country + 'S';
        cons.add(conDiffCountry);  
        insert cons;
        
        //Update the account phone number
        String phone = '5563216';
        acc.Phone    = phone;
        update acc;
        
        cons = [SELECT OtherPhone
                  FROM Contact
                 WHERE AccountId = :acc.Id
              ORDER BY LastName DESC];
        System.assertEquals(phone, cons.get(0).OtherPhone);
        System.assertEquals(null, cons.get(1).OtherPhone);
    }
}