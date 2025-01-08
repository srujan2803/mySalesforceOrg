public class NewClass {
    public static void updateContactAddress(list<Account> accList, map<id,Account> oldMap) {
        map<id, Account> addressMap = new map<id, Account>();
        for (Account acc : accList) {
            if (oldMap.get(acc.id).BillingCity != acc.BillingCity ||
               oldMap.get(acc.id).BillingCountry != acc.BillingCountry ||
               oldMap.get(acc.id).BillingState != acc.BillingState ||
               oldMap.get(acc.id).BillingStreet != acc.BillingStreet) 
                addressMap.put(acc.Id, acc);
            
        }
        
            list<Contact> outConList = new List<Contact>();
            list<Contact> conList = [select id, Name, AccountId from Contact where AccountId in : addressMap.keySet()];
            for (Contact con : conList) {
                con.MailingCity = addressMap.get(con.AccountId).BillingCity; 
                con.MailingCountry = addressMap.get(con.AccountId).BillingCountry; 
                con.MailingState = addressMap.get(con.AccountId).BillingState; 
                con.MailingStreet = addressMap.get(con.AccountId).BillingStreet; 
                outConList.add(con);
            }
            if (!outConList.isEmpty()) {
                update outConList;
            }}}