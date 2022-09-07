//Created on 2022.07.09

@isTest
public class CheckSensitiveInfoWithFoundKeywordsTest {

    @isTest static void createCaseWithSensitiveInfo() {
        //Create a new case with all required inputs
        Case myCase                     = new Case();
        myCase.Status                   = 'New';
        myCase.Origin                   = 'Web';
        myCase.Product_Purchase_Date__c = Date.today();
        myCase.Subject                  = 'Help!!!';
        myCase.Description              = 'My credit card info';
        insert myCase;
        System.debug('Case ' + myCase.Id + ' created with description ' +myCase.Description);
    }
}