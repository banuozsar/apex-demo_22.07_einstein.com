//Created on 2022.07.17

@isTest
public class OwnerManagerTest {
    @istest static void oppOwnerHasNoManager() {
        //Create a user
        User myUser = new User();
        myUser.LastName          = 'LastName';
        myUser.Alias             = 'LastName';
        myUser.Email             = 'last@name.com';
        myUser.Username          = 'last@name111lk.com';
        myUser.ProfileId         = [SELECT Id
                                      FROM Profile
                                     WHERE Name = 'System Administrator'].Id;
        myUser.TimeZoneSidKey    = 'America/Denver';
        myUser.LocaleSidKey      = 'en_US';
        myUser.ManagerId         = null;
        myUser.EmailEncodingKey  = 'UTF-8';
        myUser.LanguageLocaleKey = 'en_US';
        insert myUser;

        //Create an opp
        Opportunity opp = new Opportunity();
        opp.Name        = 'OwnerManager opp';
        opp.CloseDate   = Date.today();
        opp.StageName   = 'Prospecting';
        opp.OwnerId     = myUser.Id;
        insert opp;

        List <OpportunityTeamMember> otms = [SELECT Id
                                             FROM OpportunityTeamMember
                                            WHERE OpportunityId = :opp.Id];
        System.assertEquals(0, otms.size());
    }

    @istest static void oppOwnerHasManager() {
        //Create a manager
        User manager = new User();
        manager.LastName          = 'LastName';
        manager.Alias             = 'LastName';
        manager.Email             = 'last@name.com';
        manager.Username          = 'last@name111lk.com';
        manager.ProfileId         = [SELECT Id
                                       FROM Profile
                                      WHERE Name = 'System Administrator'].Id;
        manager.TimeZoneSidKey    = 'America/Denver';
        manager.LocaleSidKey      = 'en_US';
        manager.ManagerId         = null;
        manager.EmailEncodingKey  = 'UTF-8';
        manager.LanguageLocaleKey = 'en_US';
        insert manager;  
        
        User me = [SELECT Id
                     FROM User
                    WHERE Id = :UserInfo.getUserId()];
        me.ManagerId = manager.Id;
        update me;
        
        //Create an opp
        Opportunity opp = new Opportunity();
        opp.Name        = 'OwnerManager opp';
        opp.CloseDate   = Date.today();
        opp.StageName   = 'Prospecting';
        opp.OwnerId     = me.Id;
        insert opp;

        List<OpportunityTeamMember> otms = [SELECT Id
                                              FROM OpportunityTeamMember
                                             WHERE OpportunityId = :opp.Id
                                               AND UserId = :manager.Id
                                               AND TeamMemberRole = 'Sales Manager']; 
        System.assertEquals(1, otms.size());
    }

    @istest static void oppOwnerIsManager() {
        //Create a reportee with me as their manager
        User reportee = new User();
        reportee.LastName          = 'LastName';
        reportee.Alias             = 'LastName';
        reportee.Email             = 'last@name.com';
        reportee.Username          = 'last@name111lk.com';
        reportee.ProfileId         = [SELECT Id
                                        FROM Profile
                                       WHERE Name = 'System Administrator'].Id;
        reportee.TimeZoneSidKey    = 'America/Denver';
        reportee.LocaleSidKey      = 'en_US';
        reportee.ManagerId         = UserInfo.getUserId();
        reportee.EmailEncodingKey  = 'UTF-8';
        reportee.LanguageLocaleKey = 'en_US';
        insert reportee; 

        //Create an opp under me
        Opportunity opp = new Opportunity();
        opp.Name        = 'OwnerManager opp';
        opp.CloseDate   = Date.today();
        opp.StageName   = 'Prospecting';
        opp.OwnerId     = UserInfo.getUserId();
        insert opp;

        List<OpportunityTeamMember> otms = [SELECT Id
                                              FROM OpportunityTeamMember
                                             WHERE OpportunityId = :opp.Id
                                               AND UserId = :reportee.Id
                                               AND TeamMemberRole = 'Sales Rep']; 
        System.assertEquals(1, otms.size());
    }
}