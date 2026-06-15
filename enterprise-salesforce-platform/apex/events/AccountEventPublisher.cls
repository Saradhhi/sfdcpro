public class AccountEventPublisher {

    public static void publish(List<Account> accounts) {
        List<Account_Event__e> events = new List<Account_Event__e>();

        for (Account a : accounts) {
            events.add(new Account_Event__e(
                AccountId__c = a.Id,
                EventType__c = 'CREATED'
            ));
        }

        EventBus.publish(events);
    }
}
