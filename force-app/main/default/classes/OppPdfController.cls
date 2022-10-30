public without sharing class OppPdfController {

    public Opportunity               opp {get; set;}
    public Account                   acc {get; set;}
    public List<OpportunityLineItem> oppItems {get; set;}
    public OpportunityLineItem       oppItem {get; set;}
    public String                    remark {get; set;}
    
    public oppPdfController() {

        //remark = ApexPages.currentPage().getParameters().get('remark');

        opp = [SELECT Id,
                      Name,
                      AccountId,
                      StageName,
                      CloseDate,
                      Amount,
                      Owner.Name,
                      Owner.Email,
                      Comment__c,
                      CurrencyIsoCode,
                      HasOpportunityLineItem
                 FROM Opportunity
                WHERE Id = :ApexPages.currentPage().getParameters().get('id')
                LIMIT 1];
        System.debug('opportunity is found: ' + opp.Name);

        acc = [SELECT Name,
                      BillingAddress,
                      ShippingAddress 
                 FROM Account 
                WHERE Id = :opp.AccountId
                LIMIT 1];
        System.debug('account is found: ' + acc.Name);

        List<OpportunityLineItem> oppItem = [SELECT Product2.Name,
                                                    UnitPrice,
                                                    Quantity,
                                                    TotalPrice,
                                                    CurrencyIsoCode,
                                                    Description
                                               FROM OpportunityLineItem 
                                              WHERE OpportunityId = :opp.Id];

        oppItems = oppItem;
        System.debug(oppItems.size() + ' opportunity product(s) found.');
    }
}