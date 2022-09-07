//Created on 22.09.05

trigger OppStageUpdateEmailAlert on Opportunity (before update) {
        
    // Step 0: Create a master list to hold the emails we'll send
    List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();

    // Step 1: Get Opp info
    for (Opportunity opp : Trigger.new) {

        // Step 1.1: Access the "old" record by its ID in Trigger.oldMap
        Opportunity oldOpp = Trigger.oldMap.get(opp.Id);
    
        // Step 1.2: Get stage values of new and old records
        String oldOppStage = oldOpp.StageName;
        String newOppStage = opp.StageName;
        
        // Step 1.3: Check that the stage is changed
        if (oldOppStage != newOppStage) {
            System.debug('Opportunity Stage is changed from ' + oldOppStage + ' to ' +  newOppStage);

            // Step 1.4 Get acc name
            Account acc = [SELECT Name
                             FROM Account 
                            WHERE Id = :opp.AccountId
                            LIMIT 1];

            // Step 2: Get Opportunity Product Info
            String oppItemInfo = '';

            List<OpportunityLineItem> oppItems = [SELECT Product2.Name,
                                                         Quantity
                                                    FROM OpportunityLineItem
                                                   WHERE OpportunityId = :opp.Id];
            System.debug(oppItems.size() + ' opportunity product(s) found.');                                    
            
            if(!oppItems.isEmpty()) {
                for (OpportunityLineItem oppItem : oppItems) {
                    String oppItemName   = oppItem.Product2.Name;
                    Decimal oppItemQuant = oppItem.Quantity;
                    
                    oppItemInfo += 'Product Name: '+ oppItemName + '<br/>'
                                + 'Quantity: ' + String.valueOf(oppItemQuant) + '<br/>';
                }
            }
            
            // Step 3: Send Email
            // Step 3.1: Create a new Email
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    
            // Step 3.2: Set list of people who should get the email
            List<String> sendTo = new List<String>();
            sendTo.add('banu.ozsar@vesium.com');
            mail.setToAddresses(sendTo);
    
            // Step 3.3: Set who the email is sent from
            mail.setReplyTo('banuozsar@gmail.com');
            mail.setSenderDisplayName('Salesforce');

            // Step 3.4: Set email contents
            mail.setSubject('Opportunity Stage Update');
            String body  = 'Please see the details below.' + '<br/>' + '<br/>';
                   body += 'Account Name: ' + acc.Name + '<br/>';
                   body += 'Opportunity Name: ' + opp.Name + '<br/>';
                   body += 'Stage: ' + opp.StageName + '<br/>';
                   body += oppItemInfo + '<br/>';
                   body += 'Record Link: ' + URL.getSalesforceBaseUrl().toExternalForm() + '/' + opp.Id;
            mail.setHtmlBody(body);

            // Step 3.5: Add your email to the master list
            mails.add(mail);
            }
        }
        // Step 3.6: Send all emails in the master list
        Messaging.sendEmail(mails);
}