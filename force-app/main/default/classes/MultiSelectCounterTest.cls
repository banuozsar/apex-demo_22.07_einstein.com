//Created on 2022.07.10

@isTest
public class MultiSelectCounterTest {

    @isTest static void countMultiSelectItems() {
        //Create an account with MPS items
        Account acc = new Account();
        acc.Name    ='Multiselect';
        acc.MPS__c  = '1;2;3';
        insert acc;

        //update the account to have no MPS items
        acc.MPS__c  = null;
        update acc;
    }
}