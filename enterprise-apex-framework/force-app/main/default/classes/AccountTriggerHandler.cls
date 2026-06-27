/**
 * @description Trigger Handler for Account.
 * @author      Vijaya Saradhi Meka
 */
public with sharing class AccountTriggerHandler extends TriggerHandler {
    private List<Account> newList = (List<Account>) Trigger.new;
    private Map<Id,Account> oldMap = (Map<Id,Account>) Trigger.oldMap;

    protected override void beforeInsert() {
        AccountService.validatePhone(newList);
        AccountService.setIndustryDefault(newList);
    }
    protected override void beforeUpdate() {
        AccountService.validatePhone(newList);
    }
}
