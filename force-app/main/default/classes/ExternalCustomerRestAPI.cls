@RestResource(urlMapping='/v1/crm/accounts/*')
global with sharing class ExternalCustomerRestAPI {
    @HttpGet
    global static Account getAccountProfileData() {
        RestRequest req = RestContext.request;
        String accId = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);
        if (String.isBlank(accId)) { return null; }
        return [SELECT Id, Name, Industry, Phone FROM Account WHERE Id = :accId WITH USER_MODE LIMIT 1];
    }
}
