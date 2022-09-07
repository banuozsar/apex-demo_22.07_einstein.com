//Created on 2022.07.14

@isTest
public class MaxCasesTest {
    @istest static void noCasesToday() {
        //Create records
        Contact con  = new Contact();
        con.LastName = 'contact';
        insert con;

        Case myCase = new Case();
        myCase.ContactId = con.Id;
        myCase.Status    = 'New';
        myCase.Origin    = 'Web';
        insert myCase;

        Case updatedCase = [SELECT Status 
                              FROM Case
                             WHERE Id = :myCase.Id];
        
        System.assertEquals('New', updatedCase.Status);
    }
    @istest static void threeCasesTodayOnContact() {
        //Create records
        Contact con  = new Contact();
        con.LastName = 'contact';
        insert con;

        List<Case> oldCases = new List<Case>();
        for (Integer i = 0; i < 2; i++) {
			Case oldCase      = new Case();
			oldCase.ContactId = con.Id;
            oldCase.Status    = 'New';
            oldCase.Origin    = 'Web';            
			oldCases.add(oldCase);
        }
        insert oldCases;

        Case myCase = new Case();
        myCase.ContactId = con.Id;
        myCase.Status    = 'New';
        myCase.Origin    = 'Web';
        insert myCase;

        //Query latest values
        Case updatedCase = [SELECT Status 
                              FROM Case
                             WHERE Id = :myCase.Id];
        System.assertEquals('Closed', updatedCase.Status);
    }
    @istest static void fourCasesTodayOnAccount() {
        Account acc = new Account();
        acc.Name = 'Acc';
        insert acc;

        List<Case> oldCases = new List<Case>();
        for (Integer i = 0; i < 3; i++) {
			Case oldCase      = new Case();
			oldCase.AccountId = acc.Id;
            oldCase.Status    = 'New';
            oldCase.Origin    = 'Web';            
			oldCases.add(oldCase);
        }
        insert oldCases;    

        Case myCase = new Case();
        myCase.AccountId = acc.Id;
        myCase.Status    = 'New';
        myCase.Origin    = 'Web';
        insert myCase;

        //Query latest values
        Case updatedCase = [SELECT Status 
                              FROM Case
                             WHERE Id = :myCase.Id];
        System.assertEquals('Closed', updatedCase.Status);
    }
}