public class caseTriggerHandlerIdUpdate {
    public static void caseIdUpdate(list<Case> newlist,map<id,Case> oldmap){
        list<Account> acc = new list<Account>();
        list<Account> acc1= new list<Account>();
        list<Account> acc3= new list<Account>();
        for(Case myCase:newlist){
            
            if(newlist != null && oldmap == null){
               if(myCase.CaseNumber != null && myCase.AccountId != null){
                
                Account ac=new Account();
                ac.Id =myCase.AccountId;
                ac.Latest_Case_Number__c = myCase.CaseNumber;
                acc.add(ac);
                
                
            }
            }
           if(newlist != null && oldmap != null){
                Account ac3=new Account();
                ac3.Id =myCase.AccountId;
                ac3.Latest_Case_Number__c = myCase.CaseNumber;
                acc3.add(ac3);
                if (oldmap.get(myCase.Id) != null && oldmap.get(myCase.Id).AccountId != null){
                        Account ac1=new Account();
                   
                        ac1.Id = oldmap.get(myCase.Id).AccountId;
                        ac1.Latest_Case_Number__c = ' ';
                        acc1.add(ac1);
                    
                  } 
                }
                
                
                
                
                
             
         }
        if(!acc.isEmpty()){
          update acc;  
        }
        if(!acc1.isEmpty()){
        update acc1;
        }
        if(!acc3.isEmpty()){
        update acc3;
        }
    } 
    public static void caseIdUpdateDelete(list<Case> oldlist){
        list<Account> acc2= new list<Account>();
        for (Case ca : oldlist){
           if(ca.CaseNumber != null && ca.AccountId != null){
           Account ac2=new Account();
           ac2.Id = ca.AccountId;
           ac2.Latest_Case_Number__c = ' ';
           acc2.add(ac2);
           } 
        }
     if(!acc2.isEmpty()){
     update acc2;
     }
    }
        public static void checkAction(list<case> newList){
            
            
            for(case ca:newList){
                
                if(ca.action_plan__c ==null){
                  ca.adderror('you action cant be blank');
                }
            }
        }
            
    
        
}