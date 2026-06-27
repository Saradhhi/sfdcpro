/**
 * @description Service class for Einstein AI API interactions
 * @author Vijaya Saradhi Meka
 */
public with sharing class EinsteinAPIService {

    private static final String EINSTEIN_ENDPOINT = '/einstein/platform/v1/models/llmgateway/generations';

    public static String generateCompletion(String prompt) {
        Map<String, Object> body = new Map<String, Object>{
            'prompt' => prompt,
            'parameters' => new Map<String, Object>{ 'max_tokens' => 512, 'temperature' => 0.3 }
        };
        HttpResponse res = HttpCalloutUtil.send('Einstein_AI', EINSTEIN_ENDPOINT, 'POST', JSON.serialize(body));
        if (res.getStatusCode() == 200) {
            Map<String, Object> parsed = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            return (String) ((Map<String,Object>)((List<Object>)parsed.get('generations')).get(0)).get('text');
        }
        return null;
    }

    // Stub: in org, use real Named Credential
    private class HttpCalloutUtil {
        static HttpResponse send(String nc, String ep, String method, String b) { return new HttpResponse(); }
    }
}
