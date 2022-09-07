//Created on 2022.07.17

@isTest
public class CaseContactOwnerTest {
    @istest static void createCaseOnContact() {
        //Create records
        //Create a user as we'll need two. One will be us!
        User myUser = new User();
        myUser.LastName          = 'LastName';
        myUser.Alias             = 'LastName';
        myUser.Email             = 'last@name.com';
        myUser.Username          = 'last@name111lk.com';
        myUser.ProfileId         = [SELECT Id
                                      FROM Profile
                                     WHERE Name = 'System Administrator'].Id;
        myUser.TimeZoneSidKey    = 'America/Denver';
        myUser.LocaleSidKey      = 'en_US';
        myUser.ManagerId         = null;
        myUser.EmailEncodingKey  = 'UTF-8';
        myUser.LanguageLocaleKey = 'en_US';
        insert myUser;

        Contact con  = new Contact();
        con.LastName = 'contact';
        con.OwnerId = myUser.Id;
        insert con;

        Case myCase = new Case();
        myCase.ContactId = con.Id;
        myCase.Status    = 'New';
        myCase.Origin    = 'Web';
        insert myCase; // The CreatedById will be us, aka UserInfo.getUserId()

        Case updatedCase = [SELECT OwnerId 
                              FROM Case
                             WHERE Id = :myCase.Id];

        Contact updatedCon = [SELECT OwnerId
                                FROM Contact
                                WHERE Id = :con.Id];        
        System.assertEquals(UserInfo.getUserId(), updatedCon.OwnerId);
    }
    @istest static void createCaseOnAccount() {
        //Create records
        User myUser = new User();
        myUser.LastName          = 'LastName';
        myUser.Alias             = 'LastName';
        myUser.Email             = 'last@name.com';
        myUser.Username          = 'last@name111lk.com';
        myUser.ProfileId         = [SELECT Id
                                      FROM Profile
                                     WHERE Name = 'System Administrator'].Id;
        myUser.TimeZoneSidKey    = 'America/Denver';
        myUser.LocaleSidKey      = 'en_US';
        myUser.ManagerId         = null;
        myUser.EmailEncodingKey  = 'UTF-8';
        myUser.LanguageLocaleKey = 'en_US';
        insert myUser;

        Account acc    = new Account();
        acc.Name       = 'acc';
        acc.OwnerId = myUser.Id;
        insert acc;

        Case myCase = new Case();
        myCase.AccountId = acc.Id;
        myCase.Status    = 'New';
        myCase.Origin    = 'Web';
        insert myCase; // The CreatedById will be us, aka UserInfo.getUserId()

        Case updatedCase = [SELECT OwnerId 
                              FROM Case
                             WHERE Id = :myCase.Id];

        Account updatedAcc = [SELECT OwnerId
                                FROM Account
                                WHERE Id = :acc.Id];        
        System.assertEquals(UserInfo.getUserId(), updatedAcc.OwnerId);    
    }
}