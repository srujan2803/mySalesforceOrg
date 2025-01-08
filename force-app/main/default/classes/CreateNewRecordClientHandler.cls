public class CreateNewRecordClientHandler {
   /* public static void newRecord(){
        Clients__c cl = new Clients__c();
            cl.Name='record11';
            cl.Name_of_the_client__c = 'record11';
            cl.Active_status__c =true;
        insert cl;
    }*/
    public Static void RecordUdatewinserted(list<Clients__c> newlist){
        
        for(Clients__c acc : newlist){
            acc.phone__c = '8713893478';
            
        }
        
        
    }
}