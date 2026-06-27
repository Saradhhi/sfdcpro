/**
 * @description Selector — all Account SOQL lives here.
 * @author      Vijaya Saradhi Meka
 */
public with sharing class AccountSelector {
    public List<Account> selectById(Set<Id> ids) {
        return [SELECT Id,Name,Phone,BillingCity,Industry,AnnualRevenue,OwnerId
                FROM Account WHERE Id IN :ids WITH SECURITY_ENFORCED ORDER BY Name];
    }
    public List<Account> selectWithOpenOpps(Set<Id> ids) {
        return [SELECT Id,Name,(SELECT Id,Name,StageName,Amount,CloseDate FROM Opportunities WHERE IsClosed=FALSE)
                FROM Account WHERE Id IN :ids WITH SECURITY_ENFORCED];
    }
}
