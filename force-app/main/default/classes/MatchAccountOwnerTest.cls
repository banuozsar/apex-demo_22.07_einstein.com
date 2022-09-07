//Created on 2022.07.11
@isTest
public class MatchAccountOwnerTest {
    @isTest static void createContact() {
        Account acc    = new Account();
        acc.Name       = 'acc';
        insert acc;
        
        Contact myCon  = new Contact();
        myCon.LastName ='LastName';
        myCon.Account  = acc;
        insert myCon;
    }
}