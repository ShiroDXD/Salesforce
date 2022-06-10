@RestResource(urlMapping='/Account/*')
global with sharing class AccountManager {
    
    @HttpGet
    global static Account getAccountById() {
        RestRequest request = RestContext.request;
        // grab the accId from the end of the URL
        String accId = request.requestURI.substring(
          request.requestURI.lastIndexOf('/')+1);
        Account result =  [SELECT AccountNumber,BillingState,BillingStreet,Name,Type
                        FROM Account
                        WHERE Id = :accId];
        return result;
    }
    @HttpPost
    global static ID createAccount(String accountNumber, String billingState,
        String billingStreet, String name, String type) {
        Account thisAccount = new Account(
            AccountNumber = accountNumber,
            BillingState = billingState,
            BillingStreet = billingStreet,
            Name = name,
            Type = type);
        insert thisAccount;
        return thisAccount.Id;
    }   
    @HttpDelete
    global static void deleteAccount() {
        RestRequest request = RestContext.request;
        String accId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Account thisAccount = [SELECT Id FROM Account WHERE Id = :accId];
        delete thisAccount;
    }     
    @HttpPut
    global static ID upsertAccount(String name, String type,
        String accountNumber, String billingState, String billingStreet, String id) {
        Account thisAccount = new Account(
                Id=id,
                AccountNumber=accountNumber,
                BillingState=billingState,
                BillingStreet=billingStreet,
                Name=name,
                Type=type);
        // Match account by Id, if present.
        // Otherwise, create new account.
        upsert thisAccount;
        // Return the account ID.
        return thisAccount.Id;
    }
    @HttpPatch
    global static ID updateAccountFields() {
        RestRequest request = RestContext.request;
        String accId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Account thisAccount = [SELECT Id FROM Account WHERE Id = :accId];
        // Deserialize the JSON string into name-value pairs
        Map<String, Object> params = (Map<String, Object>)JSON.deserializeUntyped(request.requestbody.tostring());
        // Iterate through each parameter field and value
        for(String fieldName : params.keySet()) {
            // Set the field and value on the account sObject
            thisAccount.put(fieldName, params.get(fieldName));
        }
        update thisAccount;
        return thisAccount.Id;
    }
}