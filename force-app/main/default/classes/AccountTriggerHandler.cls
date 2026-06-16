public with sharing class AccountTriggerHandler extends TriggerHandler {
    protected override void beforeInsert() {
        AccountService.sanitizeAccountIndustry((List<Account>) Trigger.new);
    }
    protected override void afterInsert() {
        AccountService.generateCustomerProfile360((List<Account>) Trigger.new);
    }
}
