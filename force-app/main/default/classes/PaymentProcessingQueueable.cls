public with sharing class PaymentProcessingQueueable implements System.Queueable, Database.AllowsCallouts {
    
    private List<Id> orderIdsToProcess;
    
    public PaymentProcessingQueueable(List<Id> orderIds) {
        this.orderIdsToProcess = orderIds;
    }
    
    public void execute(System.QueueableContext context) {
        // Asynchronous execution context completely resets CPU limits to 60 seconds
        System.debug('Processing payment processing in a deferred thread framework wrapper.');
        
        // In a production setup, iterate bulk collections and fire calls out securely
        // Chaining subsequent jobs safely if collection scales breach single execution thresholds
    }
}
