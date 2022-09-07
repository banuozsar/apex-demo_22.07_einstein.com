//Created on 2022.07.01
trigger DedupeReminder on Account (after insert) {
    for (Account acc : Trigger.new) {
        Case c           = new Case();
        c.OwnerId        = '0054L000001J8IaQAK';
        c.Subject        = 'Dedupe this account';
        c.AccountId      = acc.Id;
        insert c;
    }
}