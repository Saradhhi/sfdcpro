global class AccountBatch implements Database.Batchable<SObject> {

    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, Name FROM Account');
    }

    global void execute(Database.BatchableContext bc, List<SObject> scope) {
        List<Account> accounts = (List<Account>)scope;
        for (Account a : accounts) {
            a.Description = 'Batch Updated';
        }
        update accounts;
    }

    global void finish(Database.BatchableContext bc) {
        System.debug('Batch Completed');
    }
}
