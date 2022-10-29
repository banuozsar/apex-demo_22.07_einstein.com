//Created on 2022.10.29

public class InsertAccountsWithWhile {
    public static void insertAccount(Integer n){
        Integer counter = 1;

        //create a list to add our accounts            
        List<Account> addAccounts = new List<Account>();
            
        while(counter <= n){
            //display the current counter value
            System.debug('Counter Value before Incrementing ' + counter);
            
            //create a new account
            Account acc       = new Account();
            acc.Name          = 'Acme Inc' + n;
            acc.AccountNumber = 'A000' + n;

            addAccounts.add(acc);
            System.debug(addAccounts);

            //increment the counter
            counter = counter + 1;
            System.debug('Counter Value after incrementing ' + counter);
            }

        System.debug('Size of Account List: ' + addAccounts.size() );
        System.debug('Elements in Account List: ' + addAccounts);

        //insert all of the accounts in the list
        insert addAccounts;
        }
}