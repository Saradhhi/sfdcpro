public with sharing class NightlyDataSyncScheduler implements Schedulable {
    public void execute(SchedulableContext sc) {
        Database.executeBatch(new CaseSLAMonitoringBatch(), 200);
    }
}
