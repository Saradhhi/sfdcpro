public class AccountQueueable implements Queueable {

    private List<Id> accountIds;

    public AccountQueueable(List<Id> ids) {
        this.accountIds = ids;
    }

    public void execute(QueueableContext context) {
        List<Account> accs = [SELECT Id, Name FROM Account WHERE Id IN :accountIds];

        for (Account a : accs) {
            a.Description = 'Processed via Queueable';
        }

        update accs;
    }
}
