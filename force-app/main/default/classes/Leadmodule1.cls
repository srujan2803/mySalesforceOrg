public class Leadmodule1 {
    // Method to get priority count along with agent User ID
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
}