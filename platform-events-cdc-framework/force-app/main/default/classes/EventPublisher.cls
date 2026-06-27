/**
 * @description Platform Event publisher utility
 * @author Vijaya Saradhi Meka
 */
public with sharing class EventPublisher {

    public static void publishAccountChange(List<Account> accounts) {
        List<Account_Change_Event__e> events = new List<Account_Change_Event__e>();
        for (Account a : accounts) {
            events.add(new Account_Change_Event__e(
                Account_Id__c   = a.Id,
                Account_Name__c = a.Name,
                Change_Type__c  = 'UPDATE'
            ));
        }
        List<Database.SaveResult> results = EventBus.publish(events);
        for (Database.SaveResult sr : results) {
            if (!sr.isSuccess()) {
                LoggerUtil.log(LoggerUtil.Level.ERROR, 'EventPublisher',
                    sr.getErrors()[0].getMessage());
            }
        }
    }
}
