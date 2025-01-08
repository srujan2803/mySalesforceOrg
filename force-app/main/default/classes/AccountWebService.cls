/*

@RestResource(urlMapping='/Accounts')
global with sharing class AccountWebService {

   
    @HttpGet
    global static List<Account> getAccounts() {
       
        List<Account> accounts = [SELECT Id, Name, Industry, AnnualRevenue FROM Account order by name DESC LIMIT 10];
        
        
        return accounts;
    }
    
       @HttpPost
    global static String createAccount() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;

        try {
            // Deserialize the incoming JSON request into an Account object
            String requestBody = req.requestBody.toString();
            Account newAccount = (Account) JSON.deserialize(requestBody, Account.class);

            // Insert the new Account record
            insert newAccount;

            // Return the Id of the created Account
            res.statusCode = 201;  // HTTP 201 Created
            return newAccount.Id;
        } catch (Exception e) {
            
            res.statusCode = 400; 
            return 'Error: ' + e.getMessage();
        }
    }

}*/
@RestResource(urlMapping='/Accounts')
global with sharing class AccountWebService {

    // HTTP GET method to return the list of Accounts
    @HttpGet
    global static List<Account> getAccounts() {
        // Query the latest 10 Accounts
        List<Account> accounts = [SELECT Id, Name, Industry, AnnualRevenue FROM Account ORDER BY Name DESC LIMIT 5];
        
        return accounts;
    }

    // HTTP POST method to create a new Account
    @HttpPost
    global static String createAccount() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;

        try {
            // Deserialize the incoming JSON request into an Account object
            String requestBody = req.requestBody.toString();
            Account newAccount = (Account) JSON.deserialize(requestBody, Account.class);

            // Insert the new Account record
            insert newAccount;

            // Return the Id of the created Account
            res.statusCode = 201;  // HTTP 201 Created
            return newAccount.Id;
        } catch (Exception e) {
            res.statusCode = 400;  // HTTP 400 Bad Request
            return 'Error: ' + e.getMessage();
        }
    }
}