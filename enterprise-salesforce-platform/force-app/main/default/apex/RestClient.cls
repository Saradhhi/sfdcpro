public class RestClient {

    public static String getCall(String endpoint) {
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('GET');
        HttpResponse res = http.send(req);

        if (res.getStatusCode() != 200) {
            LogService.logError('RestClient', 'Call failed with status ' + res.getStatusCode() + ': ' + res.getBody());
            return null;
        }

        return res.getBody();
    }
}
