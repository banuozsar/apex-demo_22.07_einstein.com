//Created on 2022.07.13

@isTest
public class ComparableOppsTest {
        @isTest static void noComparableOpps() {
                //Create records
                Account acc     = new Account();
                acc.Name        = 'New Acc';
                acc.Industry    = 'Hospitality';
                insert acc;

                Opportunity opp = new Opportunity();
                opp.Name        = 'New Acc Opp';
                opp.AccountId   = acc.Id;
                opp.Amount      = 100;
                opp.StageName   = 'Prospecting';
                opp.CloseDate   = Date.today();
                insert opp;

                //Query latest values
                List<Comparable__c> comparables = [SELECT Id
                                                     FROM Comparable__c
                                                    WHERE Base_Opportunity__c= :opp.Id];
                //Assert
                System.assertEquals(0, comparables.size());
        }

        @isTest static void multipleComparableOpps() {
                //Create records: we need two comparable opps
                Account acc  = new Account();
                acc.Name     = 'New Acc';
                acc.Industry = 'Hospitality';
                insert acc;

                List<Opportunity> comparableOpps = new List<Opportunity>();
                Opportunity comp1 = new Opportunity();
                comp1.Name        = 'New Acc Opp';
                comp1.AccountId   = acc.Id;
                comp1.Amount      = 105;
                comp1.StageName   = 'Closed Won';
                comp1.CloseDate   = Date.today().addDays(-1);
                comparableOpps.add(comp1);

                Opportunity comp2 = new Opportunity();
                comp2.Name        = 'New Acc Opp';
                comp2.AccountId   = acc.Id;
                comp2.Amount      = 95;
                comp2.StageName   = 'Closed Won';
                comp2.CloseDate   = Date.today().addDays(-100);
                comparableOpps.add(comp2);
                insert comparableOpps;

                Opportunity baseOpp = new Opportunity();
                baseOpp.Name        = 'New Acc Opp';
                baseOpp.AccountId   = acc.Id;
                baseOpp.Amount      = 100;
                baseOpp.StageName   = 'Prospecting';
                baseOpp.CloseDate   = Date.today();
                insert baseOpp;

                List<Comparable__c> comparables = [SELECT Id,
                                                          Comparable_Opportunity__c
                                                     FROM Comparable__c
                                                    WHERE Base_Opportunity__c = :baseOpp.Id
                                                 ORDER BY Comparable_Opportunity__r.CloseDate DESC];

                System.assertEquals(comp1.Id, comparables.get(0).Comparable_Opportunity__c);       
                System.assertEquals(comp2.Id, comparables.get(1).Comparable_Opportunity__c);          
        }
}