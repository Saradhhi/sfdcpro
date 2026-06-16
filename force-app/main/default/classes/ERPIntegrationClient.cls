public with sharing class ERPIntegrationClient {
    public static HttpResponse synchronizeClientRecord(Id accountId, String serializedPayload) {
        Http httpInstance = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:SecureERPEndpoint/v2/customers/' + accountId);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setBody(serializedPayload);
        
        HttpResponse response;
        try {
            response = httpInstance.send(request);
        } catch (Exception e) {
            response = new HttpResponse();
            response.setStatusCode(500);
            response.setBody('{"status":"error","message":"' + e.getMessage() + '"}');
        }
        return response;
    }
}
