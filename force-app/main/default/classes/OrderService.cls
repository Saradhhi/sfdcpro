public with sharing class OrderService {
    
    @AuraEnabled(cacheable=true)
    public static List<Order> getDraftOrders() {
        return [
            SELECT Id, OrderNumber, Account.Name, TotalAmount, Status, EffectiveDate 
            FROM Order 
            WHERE Status = 'Draft' 
            WITH USER_MODE 
            LIMIT 50
        ];
    }
}
