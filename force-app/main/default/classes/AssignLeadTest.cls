public class AssignLeadTest {
    
    
    
     public static String PrepopulatePriority(String Branch,String CollageName){
           
            String LeadBranch  = Branch;
            String LeadCollage = CollageName;
           
            list<String> P1Branch = new list<string>{'CSE','IT','AI','Machine Learning'};
            list<String> P2Branch = new list<string>{'Mechanical','Civil','EEE'};
            list<String> P2Collage = new list<string>{'College A','College B'};         
           
            if (P1Branch.contains(LeadBranch)) {
                return 'P1';
              } 
            else if (P2Branch.contains(LeadBranch) && P2Collage.contains(LeadCollage)) {
                return 'P2';
             }
            else {
                return 'P3';
             }
            
     }
    
    
    
    
    
    public static List<Object> getPriorityCount(String agentLanguage, String priority) {
        // Query to fetch agent capacities
        List<Agent_Capacity__c> agentMaxAndPriority = [
            SELECT User__c, Max_lead_Capacity_Per_Day__c, 
                   P1_Priority_Percentage__c, P2_Priority_Percentage__c, 
                   P3_Priority_Percentage__c, Agent_Language__c
            FROM Agent_Capacity__c
        ];
        
        // Map to store each agent's calculated capacities for each priority
        Map<Id, Map<String, Decimal>> agentCapacityMap = new Map<Id, Map<String, Decimal>>();
        Map<String, Id> agentLanguageMap = new Map<String, Id>();
        
        // Build maps for agent capacities and agent languages
        for (Agent_Capacity__c agentCapacity : agentMaxAndPriority) {
            // Create a nested map to store max capacity and calculated priorities
            Map<String, Decimal> capacityDetails = new Map<String, Decimal>();
            
            Decimal maxCapacity = agentCapacity.Max_lead_Capacity_Per_Day__c != null ? agentCapacity.Max_lead_Capacity_Per_Day__c : 0;
            
            // Calculate the actual capacity for each priority level
            Decimal p1Capacity = (agentCapacity.P1_Priority_Percentage__c != null ? agentCapacity.P1_Priority_Percentage__c : 0) * maxCapacity / 100;
            Decimal p2Capacity = (agentCapacity.P2_Priority_Percentage__c != null ? agentCapacity.P2_Priority_Percentage__c : 0) * maxCapacity / 100;
            Decimal p3Capacity = (agentCapacity.P3_Priority_Percentage__c != null ? agentCapacity.P3_Priority_Percentage__c : 0) * maxCapacity / 100;
            
            // Store values in the nested map
            capacityDetails.put('MaxCapacity', maxCapacity);
            capacityDetails.put('P1Capacity', p1Capacity);
            capacityDetails.put('P2Capacity', p2Capacity);
            capacityDetails.put('P3Capacity', p3Capacity);
            
            // Map each User to their calculated capacities
            agentCapacityMap.put(agentCapacity.User__c, capacityDetails);
            
            // Map each language to the respective agent's User ID
            agentLanguageMap.put(agentCapacity.Agent_Language__c, agentCapacity.User__c);
        }
        
        // Retrieve the User Id from the agentLanguageMap using the provided agentLanguage
        Id userId = agentLanguageMap.get(agentLanguage);
        
        if (userId != null && agentCapacityMap.containsKey(userId)) {
            // Retrieve the specific priority capacity from the map based on the priority parameter
            Map<String, Decimal> capacityDetails = agentCapacityMap.get(userId);
            Decimal priorityCount = capacityDetails.get(priority + 'Capacity'); // This should return P1Capacity, P2Capacity, or P3Capacity based on input
            
            // Return both User ID and priority count in a list
            return new List<Object>{userId, priorityCount};
        }
        
        // Return an empty list if the language or priority doesn't match any records
        return new List<Object>();
    }
    
    
    
    
    
    
    
    // Method to get the count of leads created today for a specific priority and agent
    public static Integer getLeadsCountForAgent(String agentId, String priority) {
        // Query to count leads created today for the specified agent and priority
        Integer leadCount = [
            SELECT COUNT() 
            FROM Lead 
            WHERE CreatedDate = TODAY 
              AND OwnerId = :agentId 
              AND Priority__c = :priority
        ];
        
        return leadCount;
    }
    
    
    
    
    
    
    
    public static void AssignLead(list<Lead> newLeads){
        
         for(lead nlead : newLeads){
            
            nlead.Priority__c = PrepopulatePriority(nlead.Branch__c,nlead.College__c);
            system.debug(nlead.Priority__c);
             
             
             
            list<object> AgentPriorityCount = getPriorityCount(nlead.Language__c, nlead.Priority__c);
            system.debug(AgentPriorityCount); 
            
             
              if (AgentPriorityCount.size() >= 2) {
                  // Cast the first item to Id (agentId) and second item to Decimal (priorityCount)
                  Id agentId = (Id) AgentPriorityCount[0];
                  Decimal priorityCount = (Decimal) AgentPriorityCount[1];
                  
                  // Now pass the agentId and priority as parameters to getLeadsCountForAgent
                  Integer todayLeadCount = getLeadsCountForAgent(agentId, nlead.Priority__c);
                  system.debug(todayLeadCount);
                  
                  // Assign the lead count to a variable if needed
                  Decimal todayLeadCountDecimal = (Decimal) todayLeadCount; // Convert to Decimal if needed
                  
                  if(todayLeadCountDecimal < (Decimal)AgentPriorityCount[1]){
                      nlead.OwnerId = (Id)AgentPriorityCount[0];
                      system.debug('userAssigned');
                  }
                  else{
                      nlead.OwnerId = '00GdM000007bKjh';
                      system.debug('assigned to queue');
                  }
               }
             
        }
    }
    
    
}