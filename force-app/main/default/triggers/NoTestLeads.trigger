//Created on 2022.07.10
trigger NoTestLeads on Lead (before insert, before update) {
    String testValue ='test';

    //Step 1: Find leads with 'test' in the name
    List<Lead> leadsToDisqualify = new List<Lead>();
    for (Lead myLead : Trigger.new) {
        //Check if our lead has contains 'test'
        if(myLead.FirstName   != null && myLead.FirstName.equalsIgnoreCase(testValue) 
           || myLead.LastName != null && myLead.LastName.equalsIgnoreCase(testValue)) {

            System.debug(myLead.FirstName + myLead.LastName + ' will be disqualified.');
            leadsToDisqualify.add(myLead);
        }
    }

    //Step 2: Disqualify leads
    for (Lead disqualifyLead : leadsToDisqualify) {
        disqualifyLead.Status = 'Closed - Not Converted';
    }
}