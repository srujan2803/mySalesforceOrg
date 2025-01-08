public class AssignLead {
    
    public static void PrepopulateLeadPriority(list<Lead> newLeads){
        
        for(lead nlead : newLeads){
            
            String LeadBranch = nlead.Branch__c;
            String LeadCollage= nlead.College__c;
            String LeadLanguage = nlead.Language__c;
            
            list<String> P1Branch = new list<string>{'CSE','IT','AI','Machine Learning'};
            
            list<String> P2Branch = new list<string>{'Mechanical','Civil','EEE'};
            list<String> P2Collage = new list<string>{'College A','College B'};         
           
            if (P1Branch.contains(LeadBranch)) {
                   nlead.Priority__c = 'P1';
              } 
            else if (P2Branch.contains(LeadBranch) && P2Collage.contains(LeadCollage)) {
                   nlead.Priority__c = 'P2';
             }
            else {
                nlead.Priority__c = 'P3';
             }
            
            
            
            
            
            
            
            List<Agent_Capacity__c> AgentMaxAndPriority = [
                SELECT User__c, Max_lead_Capacity_Per_Day__c, P1_Priority_Percentage__c, 
                P2_Priority_Percentage__c, P3_Priority_Percentage__c 
                FROM Agent_Capacity__c
            ];
            
            
            Map<Id, Map<String, Decimal>> agentCapacityMap = new Map<Id, Map<String, Decimal>>();
            
          
            for (Agent_Capacity__c agentCapacity : AgentMaxAndPriority) {
                
                Map<String, Decimal> capacityDetails = new Map<String, Decimal>();
                
               
                Decimal maxCapacity = agentCapacity.Max_lead_Capacity_Per_Day__c != null ? agentCapacity.Max_lead_Capacity_Per_Day__c : 0;
                
                Decimal p1Capacity = (agentCapacity.P1_Priority_Percentage__c != null ? agentCapacity.P1_Priority_Percentage__c : 0) * maxCapacity / 100;
                Decimal p2Capacity = (agentCapacity.P2_Priority_Percentage__c != null ? agentCapacity.P2_Priority_Percentage__c : 0) * maxCapacity / 100;
                Decimal p3Capacity = (agentCapacity.P3_Priority_Percentage__c != null ? agentCapacity.P3_Priority_Percentage__c : 0) * maxCapacity / 100;
                
                
                capacityDetails.put('MaxCapacity', maxCapacity);
                capacityDetails.put('P1Capacity', p1Capacity);
                capacityDetails.put('P2Capacity', p2Capacity);
                capacityDetails.put('P3Capacity', p3Capacity);
                
                
                agentCapacityMap.put(agentCapacity.User__c, capacityDetails);
            } 
            
            
            System.debug(agentCapacityMap);
            
            
            
            
            
            

         Map<String,Id> agentLanguageMap = new Map<String,Id>();

         List<Agent_Capacity__c> agentCapacityList = [SELECT User__c, Agent_Language__c FROM Agent_Capacity__c];


         for (Agent_Capacity__c record : agentCapacityList) {
   
                  agentLanguageMap.put(record.Agent_Language__c,record.User__c);
                }
            
            
            if(LeadLanguage=='Telugu'){
               nlead.OwnerId = agentLanguageMap.get('Telugu');
                
                 }
            else if(LeadLanguage == 'Hindi'){
                nlead.OwnerId = agentLanguageMap.get('Hindi');
               }
            
          }
    
    
    
    }
    
    

}