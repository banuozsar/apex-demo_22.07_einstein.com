//Created on 2022.07.14

trigger MaxCases on Case (before insert) {
    for (Case myCase: Trigger.new) {
        if (myCase.ContactId != null) {
            //Find all cases with this contact created today
            List <Case> casesToday = [SELECT Id,
                                             ContactId
                                        FROM Case
                                       WHERE ContactId   = :myCase.ContactId
                                         AND CreatedDate = TODAY];
            //If two are found, close the case
            if (casesToday.size() >= 2) {
                myCase.Status = 'Closed';
            }
        }
        
        if (myCase.AccountId != null) {
            //Find all cases with this account created today
            List<Case> casesTodayFromAccount = [SELECT Id
                                                  FROM Case
                                                 WHERE AccountId   = :myCase.AccountId
                                                   AND CreatedDate = TODAY];
            //If three are found, close the case
            if (CasesTodayFromAccount.size() >= 3) {
                myCase.Status = 'Closed';
            }
        }
    }
}