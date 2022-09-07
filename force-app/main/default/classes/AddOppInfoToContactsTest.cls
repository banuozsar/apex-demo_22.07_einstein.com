//Created on 2022.07.19

@isTest
public class AddOppInfoToContactsTest {
    @istest static void createOppOnAccount() {
        Account acc = new Account();
        acc.Name    = 'acc';
        insert acc;

        List<Contact> cons = New List<Contact>();
        for (Integer i=0; 1 < 3; i++) {
            String iString  = String.valueOf(i);
            Contact con     = new Contact();
            con.LastName    = iString;
            con.AccountId   = acc.Id;
            con.Description = iString;
            cons.add(con);
        }
        insert cons;

        Opportunity opp = new Opportunity();
        opp.Name        = 'opp';
        opp.StageName   = 'Prospecting';
        opp.CloseDate   = Date.today();
        opp.AccountId   = acc.Id;
        insert opp;

        List<Contact> updatedCons = [SELECT Description
                                       FROM Contact
                                      WHERE AccountId = :acc.Id];
        
        opp = [SELECT CreatedBy.Name,
                      CloseDate
                 FROM Opportunity
                WHERE Id = :opp.Id];

        for (Contact con : updatedCons) {
            System.assert(con.Description.contains(opp.CreatedBy.Name));
            System.assert(con.Description.contains(String.valueOf(opp.CloseDate)));
        }
    }
}