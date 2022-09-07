//Created on 2022.07.09

trigger CheckSensitiveInformation on Case (after insert, before update) {

    String childCaseSubject = 'Warning: Parent case may contain sensitive info';

    //Step 1: Create a collection containing each of our sensitive keywords
    Set<String> sensitiveKeywords = new Set<String>();
    sensitiveKeywords.add('Credit Card');
    sensitiveKeywords.add('Social Security');
    sensitiveKeywords.add('SSN');
    sensitiveKeywords.add('Passport');

    //Step 2: Check to see if our case contains any of the sensitive keywords
    List <Case> casesWithSensitiveInfo = new List<Case>();
    for (Case myCase : Trigger.new) {
        if (myCase.Subject != childCaseSubject) {
            for (String keyword : sensitiveKeywords) {
                if (myCase.Description != null && myCase.Description.containsIgnoreCase(keyword)) {
                    casesWithSensitiveInfo.add(myCase);
                    System.debug('Case'+ myCase.Id + 'includes sensitive keyword ' + keyword);
                    break;
                }
            }
        }
    }

    //Step 3: If our case contains a sensitive keyword, create a child case
    List<Case> casesToCreate = new List<Case>();
    for (Case caseWithSensitiveInfo : casesWithSensitiveInfo) {
        Case childCase        = new Case();
        childCase.Subject     = childCaseSubject;
        childCase.ParentId    = caseWithSensitiveInfo.Id;
        childCase.IsEscalated = true;
        childCase.Priority    = 'High';
        childCase.Description = 'At least one of the following keywords were found' + sensitiveKeywords;
        casesToCreate.add(childCase);
    }
    insert casesToCreate;
}