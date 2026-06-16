public with sharing class OrderProcessingService {
    
    // Mitigating CPU Timeout and Heap Limits by utilizing streaming SOQL For-Loops
    public static void processBulkOrders(Set<Id> orderIds) {
        List<Order> ordersToUpdate = new List<Order>();
        
        // Streaming standard Order records to protect heap allocation thresholds
        for (List<Order> orderBatch : [SELECT Id, Status, TotalAmount FROM Order WHERE Id IN :orderIds WITH USER_MODE]) {
            for (Order ord : orderBatch) {
                if (ord.TotalAmount > 10000) {
                    ord.Status = 'Activated'; // Utilizing standard default pickup status values
                    ordersToUpdate.add(ord);
                }
            }
            
            // Running DML cleanly outside of loop blocks
            if (!ordersToUpdate.isEmpty()) {
                Database.update(ordersToUpdate, false);
                ordersToUpdate.clear(); // Freeing heap space allocation slots immediately
            }
        }
    }
}
