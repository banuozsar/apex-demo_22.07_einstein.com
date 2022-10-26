@isTest
public class OppPdfControllerTest {
    @istest static void oppInfoRendered() {
            //Create records
            Account acc     = new Account();
            acc.Name        = 'New Acc';
            insert acc;

            Opportunity opp = new Opportunity();
            opp.Name        = 'New Acc Opp';
            opp.AccountId   = acc.Id;
            opp.StageName   = 'Prospecting';
            opp.CloseDate   = Date.today();
            insert opp;

            Product2 prod    = new Product2();
            prod.Name        = 'Product X';
            prod.ProductCode = 'Pro-X';
            prod.isActive    = true;
            insert prod;

            PricebookEntry pbEntry = new PricebookEntry();
            pbEntry.Pricebook2Id   = Test.getStandardPricebookId();
            pbEntry.Product2Id     = prod.Id;
            pbEntry.UnitPrice      = 100.00;
            pbEntry.IsActive       = true;
            insert pbEntry;

            OpportunityLineItem oppItem = new OpportunityLineItem();
            oppItem.OpportunityId       = opp.Id;
            oppItem.Quantity            = 4;
            oppItem.PricebookEntryId    = pbEntry.Id;
            oppItem.TotalPrice          = oppItem.Quantity * pbEntry.UnitPrice;
            insert oppItem;
    }
}