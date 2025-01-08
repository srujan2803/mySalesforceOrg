public class accountTriggerHandller {
    
    Public static void Method1(List<Account> acclist){
        
        system.debug('acclist size is ===' +acclist.size());
        
        system.debug('acclist value is === > ' +acclist);
        
        
        For(Account acc : acclist){
            acc.Rating = 'Hot';
            acc.Description ='account rating'+acc.rating;
            
            
            
        }
        
    }

}