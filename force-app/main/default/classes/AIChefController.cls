public with sharing class AIChefController {
    
    @AuraEnabled(cacheable=false)
    public static String generateRecipe(String ingredients) {
        try {
            if (String.isBlank(ingredients)) {
                throw new AuraHandledException('Ingredients list cannot be empty.');
            }

            // Portfolio Context Note: In an Einstein-enabled Org, you configure a template 
            // in Prompt Builder called 'RecipeGeneratorPrompt' and call it via the ConnectApi namespace.
            // For universal compatibility and sandbox validation, we establish the official execution structure:
            
            String promptText = 'You are an expert chef. Create a creative recipe using only or mostly these ingredients: ' + ingredients;
            
            // Define standard request properties for Salesforce Copilot/Einstein Core LLM Calls
            ConnectApi.EinsteinLLMGenerationRequest request = new ConnectApi.EinsteinLLMGenerationRequest();
            request.promptTemplateDeveloperName = 'RecipeGeneratorPrompt';
            
            // Fallback mock handling to ensure your portfolio demo never crashes if run in a non-AI scratch org
            if(!Test.isRunningTest() && Type.forName('ConnectApi.EinsteinLLM') != null) {
                ConnectApi.EinsteinLLMGenerationResult result = ConnectApi.EinsteinCore.generateLLMResponse(request);
                return result.textResponse;
            }
            
            // Clean markdown-style simulated AI response for demo runtime environments
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
