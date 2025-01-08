public class AccountTrigHandler {
    public static void accountStateAdd(list<Account> newlist){
         for(Account acc : newlist){
            if(acc.States__c != null){
            acc.States__c +=1;
            
            }   
          }   
    }
}