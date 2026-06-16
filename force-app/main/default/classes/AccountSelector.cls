public with sharing class AccountSelector {
    public static List<Account> getTechAccountsWithChildRecords() {
        return [SELECT Id, Name, Industry, 
                       (SELECT Id, Subject, Status FROM Cases), 
                       (SELECT Id, Amount, StageName FROM Opportunities) 
                FROM Account 
                WHERE Industry = 'Technology' 
                WITH USER_MODE 
                LIMIT 100];
    }
}
