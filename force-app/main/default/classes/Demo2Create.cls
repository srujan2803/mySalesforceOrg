public class Demo2Create {
    
    public static void method1(list<demo1__c> demo1List){
        list<demo2__c> demo2List = new list<demo2__c>();
        for(demo1__c demo1:demo1List){
           demo2__c demo2 = new demo2__c();
           demo2.Name = 'Test4';
           
           demo2List.add(demo2);
           system.debug(demo2); 
          
           
            
        
        
        }
        
        if(!demo2List.isempty())
            insert demo2List;
        
        
    }

}