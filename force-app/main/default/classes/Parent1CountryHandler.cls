public class Parent1CountryHandler {
    public static void prePopulateCode(list<Parent1__c> newlist,map<id,Parent1__c> oldlist){
        
        map<String,String> countryCodeD = new map<String,String>{'China'=>'+86','India'=>'+91','United States'=>'+1','Indonesia'=>'+62','Pakistan'=>'+92','Brazil'=>'+55','Nigeria'=>'+234','Bangladesh'=>'+880','Russia'=>'+7','Mexico'=>'+52'};
        list<Parent1__c> PhoneUpdateR = new list<Parent1__c>();
        if(newlist != null){
            for (Parent1__c eachP:newlist){
                if(eachP.Choose_Country__c != null && eachP.Phone__c != null){
                   
                   eachP.Phone__c = countryCodeD.get(eachP.Choose_Country__c) + ' '+eachP.Phone__c;
                   
                   
                }
             if(oldlist != null ){
                if(oldlist.get(eachP.Id).Choose_Country__c != null && eachP.Phone__c != null ){
                    //if(eachP.Choose_Country__c != oldlist.get(eachP.Id).Choose_Country__c){
                        
                    list<String> Temp1 = eachP.Phone__c.split(' ');
                    eachP.Phone__c = Temp1[0] + ' ' + Temp1[Temp1.size()-1];
                    system.debug(temp1);
                        
                        
                  // }   
                 } 
            
                    
              }
                
            }
            
         
        }
        
    }

}