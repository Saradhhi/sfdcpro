public with sharing class AgenticCustomerAgentService {

    public class AgentResolutionResult {
        public Id accountId { get; set; }
        public String agentAnalysisPayload { get; set; }
        public Boolean caseCreated { get; set; }
    }

    public static AgentResolutionResult executeCustomerAudit(String customerEmail) {
        AgentResolutionResult result = new AgentResolutionResult();
        
        // 1. Finds Customer by querying the Contact entity and pulling its parent Account data
        List<Contact> contacts = [SELECT AccountId, Account.Name FROM Contact 
                                  WHERE Email = :customerEmail WITH USER_MODE LIMIT 1];
        
        if (contacts.isEmpty()) {
            result.agentAnalysisPayload = 'Agentic Loop Aborted: Unable to identify customer profile by provided email reference link.';
            return result;
        }
        
        Contact targetContact = contacts[0];
        Id targetAccountId = targetContact.AccountId;
        result.accountId = targetAccountId;

        // 2. Checks Cases nested under the verified Account ID
        List<Case> activeCases = [SELECT Id, Status, Subject FROM Case 
                                  WHERE AccountId = :targetAccountId AND IsClosed = false WITH USER_MODE LIMIT 1];
        
        String caseStatusSummary = '';
        if (!activeCases.isEmpty()) {
            caseStatusSummary = ' Active blocking case discovered: ' + activeCases[0].Subject + ' (' + activeCases[0].Status + ').';
        }

        // 3. Checks Payments / Standard Orders associated with the Account ID
        List<Order> delayedOrders = [SELECT Id, OrderNumber, Status, TotalAmount FROM Order 
                                     WHERE AccountId = :targetAccountId AND Status = 'Draft' WITH USER_MODE LIMIT 5];

        // 4. Creates Response (Synthesizing intelligence strings)
        String customerName = targetContact.Account.Name != null ? targetContact.Account.Name : 'Valued Customer';
        if (!delayedOrders.isEmpty()) {
            result.agentAnalysisPayload = 'Autonomous AI Resolution for ' + customerName + ':'
                + ' Detected ' + delayedOrders.size() + ' processing hold transactions.'
                + ' Order Reference #' + delayedOrders[0].OrderNumber + ' is flagged in Draft status waiting for validation.'
                + caseStatusSummary;
        } else {
            result.agentAnalysisPayload = 'Autonomous AI Resolution for ' + customerName + ':'
                + ' No delayed order holds identified in default data ledger fields.'
                + caseStatusSummary;
        }

        // 5. Updates Salesforce (Logging the action track event record)
        Case agentAuditLog = new Case(
            AccountId = targetAccountId,
            ContactId = targetContact.Id,
            Subject = 'AI Agent Action: Automated Payment Delay Investigation',
            Description = result.agentAnalysisPayload,
            Status = 'Closed',
            Origin = 'Web'
        );
        
        try {
            Database.insert(agentAuditLog, true);
            result.caseCreated = true;
        } catch (Exception e) {
            System.debug('Agentic update failed to log: ' + e.getMessage());
            result.caseCreated = false;
        }

        return result;
    }
}
