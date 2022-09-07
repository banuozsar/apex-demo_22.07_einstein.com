//Created on 2022.07.02
trigger HelloWorld on Lead (before update) {
    for (Lead l : Trigger.new) {
        l.FirstName = 'Hello';
        l.LastName  = 'World';
    }
}