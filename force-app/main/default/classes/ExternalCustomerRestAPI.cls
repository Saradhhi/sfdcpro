@RestResource(urlMapping='/v1/customer360/*')
global with sharing class ExternalCustomerRestAPI {
    
    global class APIResponse {
        global String success;
        global String recordId;
        global String errorMessage;
    }

    @HttpPost
    global static APIResponse createCustomerRecordRecord(String companyName, String typeField, String phoneVal) {
        APIResponse responseWrapper = new APIResponse();
        
        if (String.isBlank(companyName)) {
            responseWrapper.success = 'false';
            responseWrapper.errorMessage = 'Required missing field property: companyName';
            return responseWrapper;
        }

        try {
            Account targetInsertion = new Account(
                Name = companyName,
                Type = typeField,
                Phone = phoneVal
            );
            
            insert as user targetInsertion;
            
            responseWrapper.success = 'true';
            responseWrapper.recordId = targetInsertion.Id;
            responseWrapper.errorMessage = '';
            
        } catch (Exception ex) {
            responseWrapper.success = 'false';
            responseWrapper.errorMessage = ex.getMessage();
            ExceptionHandler.logException(ex, 'ExternalCustomerRestAPI.createCustomerRecordRecord');
        }

        return responseWrapper;
    }
}
