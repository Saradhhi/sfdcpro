public with sharing class NightlyDataSyncScheduler implements System.Schedulable {
    
    public void execute(SchedulableContext sc) {
        // Instantiate and dispatch asynchronous processing logic layers cleanly
        CaseSLAMonitoringBatch slaBatchJob = new CaseSLAMonitoringBatch();
        Database.executeBatch(slaBatchJob, 50);
    }
}
