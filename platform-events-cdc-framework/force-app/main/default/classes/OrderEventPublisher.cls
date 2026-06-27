/**
 * @description Publishes Order_Created__e Platform Events.
 *              Decoupled, async — downstream systems subscribe independently.
 * @author      Vijaya Saradhi Meka
 */
public with sharing class OrderEventPublisher {

    public static void publishOrderCreated(List<Order> orders) {
        List<Order_Created__e> events = new List<Order_Created__e>();
        for (Order o : orders) {
            events.add(new Order_Created__e(
                Order_Id__c   = o.Id,
                Account_Id__c = o.AccountId,
                Amount__c     = o.TotalAmount,
                Status__c     = o.Status
            ));
        }

        List<Database.SaveResult> results = EventBus.publish(events);
        for (Integer i = 0; i < results.size(); i++) {
            if (!results[i].isSuccess()) {
                for (Database.Error e : results[i].getErrors()) {
                    System.debug('Platform Event publish error: ' + e.getMessage());
                }
            }
        }
    }
}
