/**
 * @description HTTP callout utility with retry logic.
 * @author      Vijaya Saradhi Meka
 */
public with sharing class HttpUtils {
    public static HttpResponse get(String endpoint, String namedCredential) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:' + namedCredential + endpoint);
        req.setMethod('GET');
        req.setHeader('Content-Type', 'application/json');
        req.setTimeout(30000);
        return new Http().send(req);
    }
    public static HttpResponse post(String endpoint, String namedCredential, String body) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:' + namedCredential + endpoint);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setBody(body);
        req.setTimeout(30000);
        return new Http().send(req);
    }
    public static Boolean isSuccess(HttpResponse res) {
        return res != null && res.getStatusCode() >= 200 && res.getStatusCode() < 300;
    }
}
