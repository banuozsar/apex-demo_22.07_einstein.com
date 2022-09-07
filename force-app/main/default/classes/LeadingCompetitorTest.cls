//Created on 2022.07.07
@isTest
public class LeadingCompetitorTest {

    @isTest static void createOppWithCompetitors() {
        Opportunity opp = new Opportunity();
        opp.Name        = 'LeadingCompetitorTest';
        opp.StageName   = 'Prospecting';
        opp.CloseDate   = Date.today();

        //Set competitor price fields
        opp.Competitor_1_Price__c = 5000;
        opp.Competitor_2_Price__c = 15000;
        opp.Competitor_3_Price__c = 25000;

        //Set competitor fields
        opp.Competitor_1__c = 'Amazon';
        opp.Competitor_2__c = 'Google';
        opp.Competitor_3__c = 'Microsoft';

        insert opp;
        System.debug('Opportunity '+ opp.Name + ' inserted will all competitor fields populated.');
    }
}