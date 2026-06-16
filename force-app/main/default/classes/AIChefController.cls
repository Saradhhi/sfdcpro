public with sharing class AIChefController {
    
    @AuraEnabled(cacheable=false)
    public static String generateRecipe(String ingredients) {
        try {
            if (String.isBlank(ingredients)) {
                throw new AuraHandledException('Ingredients list cannot be empty.');
            }

            // Portfolio Design Context: This class is structured to receive parameter streams from LWC.
            // In a live Einstein-enabled production org, you can invoke your Prompt Builder template here
            // using: ConnectApi.EinsteinCore.generateLLMResponse(request);
            
            // Clean markdown-style simulated AI response for robust demo presentation runtimes
            return '### ?? Chef AI Suggestion for: ' + ingredients + '\n\n' +
                   '**Recipe Title:** Gourmet Freestyle Skillet\n\n' +
                   '**Prep Time:** 10 mins | **Cook Time:** 15 mins\n\n' +
                   '**Instructions:**\n' +
                   '1. Prep and wash your available items: *' + ingredients + '*.\n' +
                   '2. Heat oil in a pan, toss them sequentially based on cook times, and season cleanly.\n' +
                   '3. Serve hot, styled professionally for your Salesforce Portfolio dashboard display!';
                   
        } catch (Exception e) {
            throw new AuraHandledException('Einstein Trust Layer Communication Error: ' + e.getMessage());
        }
    }
}
