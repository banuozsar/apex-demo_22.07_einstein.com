//Created on 2022.07.11
trigger MatchAccountOwner on Contact (before insert) {
    for (Contact myCon : Trigger.new) {
        if (myCon.AccountId != null) {
            Account acc   = [SELECT Id, 
                                    OwnerId 
                               FROM Account 
                              WHERE Id = :myCon.AccountId
                              LIMIT 1];
            myCon.OwnerId = acc.OwnerId;
        }
    }
}