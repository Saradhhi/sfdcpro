/**
 * @description Service to call Salesforce Prompt Builder templates via Connect API.
 * @author      Vijaya Saradhi Meka
 */
public with sharing class PromptTemplateService {

    public static String invokePrompt(String templateApiName, Map<String,String> inputs) {
        ConnectApi.EinsteinPromptTemplateGenerationsInput input =
            new ConnectApi.EinsteinPromptTemplateGenerationsInput();
        input.additionalConfig = new ConnectApi.EinsteinLlmAdditionalConfigInput();
        input.additionalConfig.applicationName = 'PromptTemplateGenerationsInvocable';
        input.isPreview = false;
        input.inputParams = new Map<String, ConnectApi.WrappedValue>();

        for (String key : inputs.keySet()) {
            ConnectApi.WrappedValue val = new ConnectApi.WrappedValue();
            val.value = inputs.get(key);
            input.inputParams.put(key, val);
        }

        ConnectApi.EinsteinPromptTemplateGenerationsRepresentation result =
            ConnectApi.EinsteinLLM.generateMessagesForPromptTemplate(templateApiName, input);

        return result?.generations?.isEmpty() == false
            ? result.generations[0].text
            : 'No response generated.';
    }
}
