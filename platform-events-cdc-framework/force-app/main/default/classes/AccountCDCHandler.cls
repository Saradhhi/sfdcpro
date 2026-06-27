/**
 * @description Handles AccountChangeEvent (CDC) — syncs Account changes to external system.
 * @author      Vijaya Saradhi Meka
 */
public with sharing class AccountCDCHandler {

    public static void handleAccountChanges(List<AccountChangeEvent> events) {
        List<String> externalSyncPayloads = new List<String>();

        for (AccountChangeEvent event : events) {
            EventBus.ChangeEventHeader header = event.ChangeEventHeader;
            if (header.changeType == 'CREATE' || header.changeType == 'UPDATE') {
                Map<String,Object> payload = new Map<String,Object>{
                    'changeType'  => header.changeType,
                    'recordIds'   => header.recordIds,
                    'changedFields' => header.changedFields,
                    'name'        => event.Name,
                    'phone'       => event.Phone,
                    'industry'    => event.Industry
                };
                externalSyncPayloads.add(JSON.serialize(payload));
            }
        }

        if (!externalSyncPayloads.isEmpty()) {
            // Enqueue async callout to external system
            System.enqueueJob(new ExternalSyncQueueable(externalSyncPayloads));
        }
    }
}
