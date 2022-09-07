//Created on 2022.07.09

trigger CheckSensitiveInformationWithFoundKeywords on Case (after insert, before update) {

    String childCaseSubject = 'Warning: Parent case may contain sensitive info';

    //Step 1: Create a collection containing each of our sensitive keywords
    Set<String> sensitiveKeywords = new Set<String>();
    sensitiveKeywords.add('Credit Card');
    sensitiveKeywords.add('Social Security');
    sensitiveKeywords.add('SSN');
    sensitiveKeywords.add('Passport');

    //Step 2: Check to see if our case contains any of the sensitive keywords
    List<String> keywordsFound = new List<String>();
    Map<Id, List<String>> keywordsByCaseId = new Map<Id, List<String>>();

    for (Case myCase : Trigger.new) {
        List<String> keywordsFound = new List<String>();
        if (myCase.Subject != childCaseSubject) {
            for (String keyword : sensitiveKeywords) {
                if (myCase.Description != null && myCase.Description.containsIgnoreCase(keyword)) {
                    keywordsFound.add(keyword);
                    System.debug('Case'+ myCase.Id + 'includes sensitive keyword ' + keyword);
                    break;
                }
            }
            keywordsByCaseId.put(myCase.Id, keywordsFound);
            System.debug('Map values: '         + keywordsByCaseId.get(myCase.Id));
            System.debug('Number of keywords: ' + keywordsByCaseId.get(myCase.Id).size());
            System.debug('Map content: '        + keywordsByCaseId);
        }
    }

    //Step 3: If our case contains a sensitive keyword, create a child case
    List<Case> casesToCreate = new List<Case>();
    for (Id id : keywordsByCaseId.keySet()) {
        String keywords = String.join(keywordsByCaseId.get(id), ',');
        Case childCase           = new Case();
        childCase.Subject        = childCaseSubject;
        childCase.ParentId       = id;
        childCase.IsEscalated    = true;
        childCase.Priority       = 'High';
        Integer numberOfKeywords = keywordsByCaseId.get(id).size();
        childCase.Description    = numberOfKeywords + (numberOfKeywords >= 2 ? ' keywords were' : ' keyword was') + ' found ' + keywords;
        casesToCreate.add(childCase);
    }
    insert casesToCreate;
}