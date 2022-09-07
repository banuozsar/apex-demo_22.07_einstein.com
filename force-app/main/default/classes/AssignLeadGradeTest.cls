//Created on 2022.07.07
@isTest
public class AssignLeadGradeTest {

    @isTest static void createLead() {
        Lead myLead      = new Lead();
        myLead.FirstName = 'Banu';
        myLead.LastName  = 'Oz';
        myLead.Company   = 'DreamForce';
        myLead.Score__c  = 100;
        insert myLead;

        myLead.Score__c  = 90;
        update myLead;

        myLead.Score__c  = 80;
        update myLead;

        myLead.Score__c  = 70;
        update myLead;
    }
}