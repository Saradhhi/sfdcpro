public with sharing class CustomerSearchEngine {
    
    @AuraEnabled(cacheable=true)
    public static Map<String, List<SObject>> executeGlobalCustomerSearch(String searchKeyword) {
        if (String.isBlank(searchKeyword) || searchKeyword.length() < 3) {
            return new Map<String, List<SObject>>();
        }

        try {
            List<List<SObject>> searchResults = [
                FIND :searchKeyword
                IN ALL FIELDS
                RETURNING 
                    Account(Id, Name, AccountNumber, Phone), 
                    Contact(Id, Name, Email, Phone), 
                    Case(Id, CaseNumber, Subject, Status)
                WITH USER_MODE
                LIMIT 100
            ];

            return new Map<String, List<SObject>>{
                'Accounts' => searchResults[0],
                'Contacts' => searchResults[1],
                'Cases' => searchResults[2]
            };
            
        } catch (Exception ex) {
            ExceptionHandler.logException(ex, 'CustomerSearchEngine.executeGlobalCustomerSearch');
            throw new AuraHandledException('Search runtime failure encountered: ' + ex.getMessage());
        }
    }
}
