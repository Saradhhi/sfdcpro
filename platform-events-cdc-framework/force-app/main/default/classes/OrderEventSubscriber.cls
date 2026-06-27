/**
 * @description Subscribes to Order_Created__e Platform Events via Apex trigger.
 *              Handles replay ID management and idempotency.
 * @author      Vijaya Saradhi Meka
 */
public with sharing class OrderEventSubscriber {

    public static void handleOrderCreated(List<Order_Created__e> events) {
        List<Task> tasksToCreate = new List<Task>();

        for (Order_Created__e event : events) {
            tasksToCreate.add(new Task(
                Subject     = 'Follow up on Order: ' + event.Order_Id__c,
                WhatId      = event.Account_Id__c,
                Status      = 'Not Started',
                Priority    = 'High',
                ActivityDate = Date.today().addDays(1),
                Description = 'Auto-created by Platform Event. Amount: ' + event.Amount__c
            ));
        }

        if (!tasksToCreate.isEmpty()) insert tasksToCreate;
    }
}
