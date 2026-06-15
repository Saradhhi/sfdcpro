public with sharing class ExternalServiceClient {

    public class ExternalResponse {
        @AuraEnabled public String status;
        @AuraEnabled public String payload;
    }

    public static ExternalResponse fetchData(String endpointUrl) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpointUrl);
        req.setMethod('GET');
        req.setHeader('Accept', 'application/json');

        Http http = new Http();
        HttpResponse res = http.send(req);

        ExternalResponse result = new ExternalResponse();
        result.status = String.valueOf(res.getStatus());
        result.payload = res.getBody();
        return result;
    }
}
