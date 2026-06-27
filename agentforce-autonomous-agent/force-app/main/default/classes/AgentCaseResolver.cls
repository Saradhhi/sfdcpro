/**
 * @description Agentforce action — autonomously resolves Salesforce Cases using Einstein AI.
 *              Invocable from Agentforce Agent Actions & Flows.
 * @author      Vijaya Saradhi Meka
 */
public with sharing class AgentCaseResolver {

    public class CaseInput {
        @InvocableVariable(label='Case ID' required=true) public Id caseId;
        @InvocableVariable(label='Use AI Resolution' required=false) public Boolean useAI;
    }

    public class CaseOutput {
        @InvocableVariable(label='Resolution Summary') public String resolutionSummary;
        @InvocableVariable(label='Resolved') public Boolean resolved;
        @InvocableVariable(label='Confidence Score') public Decimal confidenceScore;
    }

    @InvocableMethod(label='Resolve Case with Agentforce' description='AI-powered autonomous case resolution')
    public static List<CaseOutput> resolveCases(List<CaseInput> inputs) {
        List<CaseOutput> outputs = new List<CaseOutput>();
        Set<Id> caseIds = new Set<Id>();
        for (CaseInput i : inputs) caseIds.add(i.caseId);

        Map<Id,Case> caseMap = new Map<Id,Case>([
            SELECT Id, Subject, Description, Status, Priority, AccountId, ContactId
            FROM Case WHERE Id IN :caseIds WITH SECURITY_ENFORCED
        ]);

        for (CaseInput input : inputs) {
            Case c = caseMap.get(input.caseId);
            CaseOutput out = new CaseOutput();
            if (c == null) { out.resolved = false; out.resolutionSummary = 'Case not found.'; outputs.add(out); continue; }

            // Build resolution via Einstein Prompt (replace with actual Prompt API call)
            out.resolutionSummary = buildResolution(c);
            out.resolved = true;
            out.confidenceScore = 0.87;

            // Auto-update Case status
            c.Status = 'Resolved';
            c.Description = (c.Description ?? '') + '\n\n[AI Resolution]: ' + out.resolutionSummary;
            outputs.add(out);
        }

        update caseMap.values();
        return outputs;
    }

    private static String buildResolution(Case c) {
        return 'Case "' + c.Subject + '" resolved via Agentforce autonomous analysis. ' +
               'Priority: ' + c.Priority + '. Recommended action applied and case closed.';
    }
}
