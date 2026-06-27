/**
 * @description Async Queueable for external system sync callouts.
 * @author      Vijaya Saradhi Meka
 */
public class ExternalSyncQueueable implements Queueable, Database.AllowsCallouts {
    private List<String> payloads;
    public ExternalSyncQueueable(List<String> payloads) { this.payloads = payloads; }

    public void execute(QueueableContext ctx) {
        for (String payload : payloads) {
            HttpRequest req = new HttpRequest();
            req.setEndpoint('callout:External_ERP_NC/api/sync/account');
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json');
            req.setBody(payload);
            req.setTimeout(30000);
            HttpResponse res = new Http().send(req);
            if (res.getStatusCode() < 200 || res.getStatusCode() >= 300) {
                System.debug('External sync failed: ' + res.getBody());
            }
        }
    }
}
