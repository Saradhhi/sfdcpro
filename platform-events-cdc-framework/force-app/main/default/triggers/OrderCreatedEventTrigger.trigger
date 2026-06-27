/**
 * @description Trigger on Order_Created__e Platform Event.
 * @author      Vijaya Saradhi Meka
 */
trigger OrderCreatedEventTrigger on Order_Created__e (after insert) {
    OrderEventSubscriber.handleOrderCreated(Trigger.new);
}
