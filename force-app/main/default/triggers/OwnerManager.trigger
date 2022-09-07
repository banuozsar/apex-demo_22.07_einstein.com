//Created on 2022.07.17

trigger OwnerManager on Opportunity (after insert) {
    for(Opportunity opp: Trigger.new) {
        //Get opp owner manager info
        User ownerWithManagerInfo = [SELECT ManagerId
                                       FROM User
                                      WHERE Id = :opp.OwnerId];
        
        //Prep a list of team members for later use
        List <OpportunityTeamMember> otms = new List <OpportunityTeamMember>();
        
        //Create the member for the manager
        if (ownerWithManagerInfo.ManagerId != null) {
            //Create OpportunityTeamMember record
            OpportunityTeamMember otm  = new OpportunityTeamMember();
            otm.OpportunityId          = opp.Id;
            otm.UserId                 = ownerWithManagerInfo.ManagerId;
            otm.TeamMemberRole         = 'Sales Manager';
            otm.OpportunityAccessLevel = 'Edit';     
            otms.add(otm); 
        }

        //Check if the owner is a manager
        List<User> reportees = [SELECT Id
                                  FROM User
                                 WHERE ManagerId = :opp.OwnerId];
        
        //Create the member for the reportee
        if (!reportees.isEmpty()) {
            OpportunityTeamMember reporteeMember  = new OpportunityTeamMember();
            reporteeMember.OpportunityId          = opp.Id;
            reporteeMember.UserId                 = reportees.get(0).Id;
            reporteeMember.TeamMemberRole         = 'Sales Rep';
            reporteeMember.OpportunityAccessLevel = 'Edit';
            otms.add(reporteeMember);             
        }
        
        //Insert all members at once
        if (!otms.isEmpty()) {
            insert otms;
        }
    }
}