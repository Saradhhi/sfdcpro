public with sharing class CustomerSelector {
    
    private static final String DEFAULT_ACCOUNT_FIELDS = 'Id, Name, AccountNumber, Type, Industry, Phone';
    
    public static List<Account> getAccountsByIds(Set<Id> accountIds) {
        if (accountIds == null || accountIds.isEmpty()) {
            return new List<Account>();
        }
        
        // Emulating an Enterprise Query Factory pattern with dynamic, selective indexing
        String query = 'SELECT ' + DEFAULT_ACCOUNT_FIELDS + ' FROM Account WHERE Id IN :accountIds';
        return (List<Account>)Database.query(String.escapeSingleQuotes(query));
    }

    public static List<Case> getOpenCasesWithAccountContext() {
        // Enforcing index selection and preventing table scans (Avoids SOQL inside loops)
        return [
            SELECT Id, CaseNumber, Status, Priority, Subject, AccountId, Account.Name, Account.AccountNumber
            FROM Case
            WHERE Status = 'Open' AND AccountId != null
            WITH USER_MODE
            LIMIT 50000
        ];
    }
}
