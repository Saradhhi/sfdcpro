public with sharing class AccountService {
    public static void sanitizeAccountIndustry(List<Account> records) {
        for (Account acc : records) {
            if (String.isBlank(acc.Industry)) {
                acc.Industry = 'Technology'; // Standard portfolio baseline mapping
            }
        }
    }

    public static void generateCustomerProfile360(List<Account> records) {
        List<Customer_360_Profile__c> profilesToInsert = new List<Customer_360_Profile__c>();
        for (Account acc : records) {
            profilesToInsert.add(new Customer_360_Profile__c(
                Customer__c = acc.Id,
                Customer_Score__c = 100.00,
                Risk_Level__c = 'Low'
            ));
        }
        if (!profilesToInsert.isEmpty()) {
            Database.insert(profilesToInsert, true);
        }
    }
}
