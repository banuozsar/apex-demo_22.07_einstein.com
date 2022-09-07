//Created on 2022.07.10
@isTest
public class NoTestLeadsTest {

    @isTest static void createLead() {
        Lead myLead      = new Lead();
        myLead.FirstName = 'Banu';
        myLead.LastName  = 'test';
        myLead.Company   = 'DreamForce';
        insert myLead;
    }
}