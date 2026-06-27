/**
 * @description Invocable action handler for Agentforce agent topics
 * @author Vijaya Saradhi Meka
 */
public with sharing class AgentforceActionHandler {

    @InvocableMethod(label='Resolve Case with AI' description='Uses Einstein AI to suggest case resolution')
    public static List<CaseResolutionResult> resolveCase(List<CaseResolutionRequest> requests) {
        List<CaseResolutionResult> results = new List<CaseResolutionResult>();
        for (CaseResolutionRequest req : requests) {
            CaseResolutionResult res = new CaseResolutionResult();
            res.suggestedSolution = 'AI Resolution for: ' + req.caseSubject;
            res.confidenceScore   = 0.92;
            res.nextBestAction    = 'Send resolution email to customer';
            results.add(res);
        }
        return results;
    }

    public class CaseResolutionRequest {
        @InvocableVariable(required=true label='Case Subject')   public String caseSubject;
        @InvocableVariable(required=true label='Case Description') public String caseDescription;
        @InvocableVariable(label='Account Name') public String accountName;
    }

    public class CaseResolutionResult {
        @InvocableVariable(label='Suggested Solution')  public String suggestedSolution;
        @InvocableVariable(label='Confidence Score')    public Double  confidenceScore;
        @InvocableVariable(label='Next Best Action')    public String  nextBestAction;
    }
}
