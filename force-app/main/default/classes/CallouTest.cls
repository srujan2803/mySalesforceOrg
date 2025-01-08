public class CallouTest {
    
    
   

    public static void getCallouts() {

        Http http = new Http();
        HttpRequest request = new HttpRequest();

       
        request.setEndpoint('callout:test/services/apexrest/AccountService');
        
        request.setMethod('GET');

        try {
            // Send the request
            HttpResponse response = http.send(request);

            // Log the status code and body for better debugging
            System.debug('Status Code: ' + response.getStatusCode());
            System.debug('Response Body: ' + response.getBody());

            if (response.getStatusCode() == 200) {
                System.debug('Response: ' + response.getBody());
            } else {
                System.debug('Error: ' + response.getStatusCode() + ' - ' + response.getStatus());
            }

        } catch (Exception e) {
            System.debug('Exception: ' + e.getMessage());
        }
    }



}