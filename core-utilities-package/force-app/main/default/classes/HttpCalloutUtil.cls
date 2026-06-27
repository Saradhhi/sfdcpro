/** @description Centralised HTTP callout handler | @author Vijaya Saradhi Meka */
public with sharing class HttpCalloutUtil {
    public static HttpResponse send(String namedCredential, String endpoint, String method, String body) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:' + namedCredential + endpoint);
        req.setMethod(method);
        req.setHeader('Content-Type', 'application/json');
        req.setTimeout(30000);
        if (String.isNotBlank(body)) req.setBody(body);
        HttpResponse res = new Http().send(req);
        if (res.getStatusCode() >= 400) {
            LoggerUtil.log(LoggerUtil.Level.ERROR, 'HttpCalloutUtil', 'HTTP ' + res.getStatusCode() + ': ' + res.getBody());
        }
        return res;
    }
}
