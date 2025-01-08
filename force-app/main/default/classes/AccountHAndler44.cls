public class AccountHAndler44 {
    
    public static void method1(list<Account> acclist){
        
        
        list<AggregateResult> agg = [select count(id),Industry from Account group by Industry];
        
       
        
        for(Account acc:acclist){
            string userInpu = acc.Industry;
            list<sObject> acou=[select count(Id) from Account where Industry =:userInpu];
            system.debug('@@@ count value new'+acou);
           
            
        }
        
     
    }

}