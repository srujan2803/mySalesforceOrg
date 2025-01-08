public class PositionAutoPop {
    public static void Autopopulate(list<position__c> newlist){
        for(position__c myPosition : newlist){
            if(myPosition.open_date__c == null){
                myPosition.open_date__c = date.today();
            }
            if(myPosition.Min_Pay__c == null){
                myPosition.Min_Pay__c = 10000;
            } 
            if(myPosition.Max_Pay__c == null){
                myPosition.Max_Pay__c = 150000;
            } 
         
        }
    }
    
}