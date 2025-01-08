public class ProjectChildControl {
    
    public static void controlParent(list<Lease__c> newlist){
        set<id> oldid= new set<id>();
        for(Lease__c ch: newlist){
            oldid.add(ch.Property__c);
        }
        list<AggregateResult> agriResult=[Select Property__c,Count(id)counting from Lease__c where Property__c in: oldid
                                          Group by Property__c];
        map<id,integer> result= new map<id,integer>();
        for(AggregateResult ar:agriResult){
            result.put((id)ar.get('Property__c'),(integer)ar.get('counting'));
        }
        for(Lease__c  ch :newlist){
            integer count= result.get(ch.Property__c);
            if(count==null){
                count=0;
            }
            if(count>=3){
                ch.addError('not morethan 3 childs');
                }
            
        }
      }
}