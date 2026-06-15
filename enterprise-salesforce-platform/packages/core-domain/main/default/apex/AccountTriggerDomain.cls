public class AccountTriggerDomain {

    public static void handle() {
        if (Trigger.isBefore) {
            AccountService.applyRules((List<Account>)Trigger.new);
        }

        if (Trigger.isAfter && Trigger.isInsert) {
            AccountEventPublisher.publish((List<Account>)Trigger.new);
        }
    }
}
