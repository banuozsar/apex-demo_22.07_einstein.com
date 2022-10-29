//Created on 2022.10.29
@isTest
public class InsertAccountsWithWhileTest {
    @isTest static void createAcc() {

        Integer counter = 1;
        Integer n = 2;

        List<Account> addAccounts = new List<Account>();

        while(counter <= n){            
            //create a new account
            Account acc       = new Account();
            acc.Name          = 'Acme Inc' + n;
            acc.AccountNumber = 'A000' + n;

            addAccounts.add(acc);

            //increment the counter
            counter = counter + 1;
            }

        System.assertEquals(2, addAccounts.size());
    }
}