//Created on 2022.07.19

@isTest
public class AccountMatcherTest {
    
    @istest static void noAccountMatch() {
        Contact con        = new Contact();
        con.LastName       = 'contact';
        con.Email          = 'contact@xmail.com';
        insert con;

        Contact updatedCon = [SELECT AccountId
                                FROM Contact
                               WHERE Id = :con.Id];
        System.assertEquals(null, updatedCon.AccountId);
    }

    @istest static void accountMatchFound() {
        String domain = 'xxxy.com';

        //Create records
        Account acc        = new Account();
        acc.Name           = 'acc';
        acc.Website        = 'www.'+ domain;
        insert acc;

        Contact con        = new Contact();
        con.LastName       = 'contact';
        con.Email          = 'contact@' + domain;
        insert con;

        Contact updatedCon = [SELECT AccountId
                                FROM Contact
                               WHERE Id = :con.Id];
        System.assertEquals(acc.Id, updatedCon.AccountId);
    }
}