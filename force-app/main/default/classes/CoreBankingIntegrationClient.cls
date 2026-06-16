public with sharing class CoreBankingIntegrationClient {

    // Outbound Synchronization API sending secure core banking telemetry payloads
    public static HttpResponse syncFinancialDataWithCore(Id financialAccountId, String complexJsonPayload) {
        Http httpObj = new Http();
        HttpRequest request = new HttpRequest();
        
        // Utilizing Named Credentials architecture abstractions to securely lock down integration tokens
        request.setEndpoint('callout:CoreBankingSecureEndpoint/v1/accounts/' + financialAccountId);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Accept', 'application/json');
        request.setBody(complexJsonPayload);
        
        HttpResponse response;
        try {
            response = httpObj.send(request);
            if (response.getStatusCode() != 200) {
                System.debug('Core Banking System API flagged an error frame: ' + response.getBody());
            }
        } catch (Exception e) {
            System.debug('Callout transaction runtime block encountered a critical exception layer: ' + e.getMessage());
            response = new HttpResponse();
            response.setStatusCode(500);
            response.setBody('{"error": "Salesforce Integration Timeout Fault Intercept Logic Stack Activated"}');
        }
        
        return response;
    }
}
