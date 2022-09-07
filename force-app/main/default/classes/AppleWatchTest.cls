//Created on 2022.07.01

@isTest
public class AppleWatchTest {

    @isTest static void createOpportunity() {
        Opportunity opp = new Opportunity();
        opp.Name        = 'AppleWatch Deal';
        opp.StageName   = 'Prospecting';
        opp.CloseDate   = Date.today();
        insert opp;
    }
}