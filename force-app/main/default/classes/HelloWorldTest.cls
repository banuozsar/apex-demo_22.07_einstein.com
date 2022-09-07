//Created on 2022.07.02
@isTest
public class HelloWorldTest {
    
    @isTest static void updateLead() {
        Lead myLead      = new Lead();
        myLead.FirstName = 'Banu';
        myLead.LastName  = 'Oz';
        myLead.Company   = 'DreamForce';
        insert myLead;
        
        myLead.Company   = 'Pluralsight';
        update myLead;
    }
}