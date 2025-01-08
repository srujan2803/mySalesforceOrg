public class Child1Handler{
    public static void method1(list<Child1__c> newlist,map<id,Child1__c> oldlist){
        list<Parent1__c> parentIds = new list<Parent1__c>();
        
        if(newlist != null){
            for(Child1__c c:newlist){
                if(c.Amount1__c != null && c.Choose_Parent1__c != null){
                     if(c.Amount1__c > 1000){
                          Parent1__c ch = [select id,Above_1000__c from Parent1__c where id = :c.Choose_Parent1__c limit 1];
                          if(ch.Above_1000__c == null)
                               ch.Above_1000__c = 0;
                          ch.Above_1000__c = ch.Above_1000__c + 1  ;
                          parentIds.add(ch);
                      if(oldlist != null)  { 
                         if(oldlist.get(c.Id).Choose_Parent1__c != null){
                               Parent1__c cc = [select id,Above_1000__c from Parent1__c where id = :oldlist.get(c.Id).Choose_Parent1__c limit 1];
                               cc.Above_1000__c = cc.Above_1000__c - 1;
                               parentIds.add(cc);
                          }
                      }
                    }
                    if(c.Amount1__c <= 1000){
                         Parent1__c ch = [select id,Below_1000__c from Parent1__c where id = :c.Choose_Parent1__c limit 1];
                         if(ch.Below_1000__c == null)
                              ch.Below_1000__c = 0;
                      
                         ch.Below_1000__c = ch.Below_1000__c + 1  ;
                         parentIds.add(ch);
                    if(oldlist != null)  { 
                         if(oldlist.get(c.Id).Choose_Parent1__c != null){
                               Parent1__c cc = [select id,Below_1000__c from Parent1__c where id = :oldlist.get(c.Id).Choose_Parent1__c limit 1];
                               cc.Below_1000__c = cc.Below_1000__c - 1;
                               parentIds.add(cc);
                          }
                      }
                                               
                    }
                        
                 }
                    
              }
          }
        if(newlist==null && oldlist !=null){
           system.debug(oldlist);
          
        }
            
          if(!parentIds.isempty())
              update parentIds;
      }
 }