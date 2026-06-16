public with sharing class ERPIntegrationClient {
    
    public class ERPPayloadWrapper {
        public String accountId;
        public String companyName;
        public String statusFlag;
    }

    @AuraEnabled
    public static Integer synchronizeCustomerWithERPSystem(Id accountId) {
        List<Account> targetAccounts = CustomerSelector.getAccountsByIds(new Set<Id>{ accountId });
        if (targetAccounts.isEmpty()) return 404;
        
        Account target = targetAccounts[0];

        // Structural compilation utilizing strong data typing parameters
        ERPPayloadWrapper payload = new ERPPayloadWrapper();
        payload.accountId = target.Id;
        payload.companyName = target.Name;
        payload.statusFlag = 'ACTIVE';

        HttpRequest request = new HttpRequest();
        // Utilizing a production-grade secure configuration abstraction tier
        request.setEndpoint('callout:ERP_System_Endpoint/v1/customers');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json; charset=utf-8');
        request.setBody(JSON.serialize(payload));

        Http httpProtocol = new Http();
        try {
            HttpResponse response = httpProtocol.send(request);
            if (response.getStatusCode() != 200 && response.getStatusCode() != 201) {
                System.debug(LoggingLevel.ERROR, 'ERP Server Integration Fault Code: ' + response.getStatusCode());
            }
            return response.getStatusCode();
        } catch (Exception ex) {
            ExceptionHandler.logException(ex, 'ERPIntegrationClient.synchronizeCustomerWithERPSystem');
            return 500;
        }
    }
}
