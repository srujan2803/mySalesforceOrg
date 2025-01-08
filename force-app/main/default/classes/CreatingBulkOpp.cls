public class CreatingBulkOpp {
    
    public static void method1(list<Account> newlist){
        
        for(Account myAcc : newlist){
          methodFuture(myAcc.Id,myAcc.Name);      
        }
    }
    
    @future
    public static void methodFuture(id AccId,String AccName){
        list<Opportunity> oppList = new list<Opportunity>();
        for(Integer i=1;i<100;i++){
          Opportunity myOpp = new Opportunity();
          myOpp.Name        = AccName+'OPP'+String.valueof(i);
          myOpp.AccountId   = AccId;
          myOpp.Amount      = 0;
          myOpp.StageName   = 'Prospecting';
          myOpp.CloseDate   = Date.today();
          oppList.add(myOpp);
        }
       if(!oppList.isempty())
           insert oppList;
    }

}