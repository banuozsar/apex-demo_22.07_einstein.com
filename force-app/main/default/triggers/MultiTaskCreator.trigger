//Created on 2022.07.10
trigger MultiTaskCreator on Account (before insert, before update) {
    for (Account acc : Trigger.new) {
        if (acc.MPS__c != null) {
            //Step 1: Create a list of all selected items
            List<String> selectedItems = new List<String>();
            selectedItems = acc.MPS__c.split(';');
            System.debug('Items selected: ' + selectedItems);

            //Step 2: Create a task for each selected items
            List<Task> tasksToCreate = new List<Task>();
            for (String item: selectedItems) {
                System.debug('Creating a new task for item: ' + item);
                Task myTask    = new Task();
                myTask.Subject = item;
                myTask.WhatId  = acc.Id;
                tasksToCreate.add(myTask);
            }
            insert tasksToCreate;
        }
    }
}