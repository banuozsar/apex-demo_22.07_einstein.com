//Created on 2022.07.18

trigger AccountMatcher on Contact (before insert) {
    for(Contact con : Trigger.new) {
        if (con.Email != null) {
            String domain  = con.Email.split('@').get(1);
            String website = 'www.' + domain;
            System.debug('Matching ' +con.FirstName + ' to website: ' + website);

            List<Account> matchingAccounts = [SELECT Id
                                                FROM Account
                                               WHERE Website = :website];

            //If there is exactly one match, move to the contact
            if(matchingAccounts.size() == 1) {
                con.AccountId = matchingAccounts.get(0).Id;
            }
        }
    }
}