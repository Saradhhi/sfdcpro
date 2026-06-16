public with sharing class CaseSLAMonitoringBatch implements Database.Batchable<SObject> {
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT Id, Status FROM Case WHERE IsClosed = false]);
    }
    public void execute(Database.BatchableContext bc, List<Case> scope) {
        for (Case c : scope) {
            c.Priority = 'High';
        }
        Database.update(scope, false);
    }
    public void finish(Database.BatchableContext bc) {
        System.debug('Nightly CRM execution batch monitoring engine runs successfully terminated.');
    }
}
