public class LeadAssignmentHelper {
    public static void assignLeads(List<Lead> newLeads) {
        // Fetch agent capacities and languages
        List<Agent_Capacity__c> agentCapacities = [
            SELECT User__c, 
                   P1_Priority_Percentage__c, 
                   P2_Priority_Percentage__c, 
                   P3_Priority_Percentage__c, 
                   Max_lead_Capacity_Per_Day__c, 
                   Agent_Language__c 
            FROM Agent_Capacity__c
        ];
        
        // Create a map for agent capacities
        Map<String, Agent_Capacity__c> agentCapacityMap = new Map<String, Agent_Capacity__c>();
        for (Agent_Capacity__c ac : agentCapacities) {
            String key = ac.User__c + '-' + ac.Agent_Language__c;
            agentCapacityMap.put(key, ac);
        }
        
        // Fetch today's lead counts
        List<AggregateResult> leadCounts = [
            SELECT OwnerId, 
                   COUNT(Id) leadCount, 
                   Priority__c 
            FROM Lead 
            WHERE CreatedDate = TODAY 
            GROUP BY OwnerId, 
                     Priority__c
        ];
        
        // Create a map for lead counts
        Map<String, Integer> leadCountMap = new Map<String, Integer>();
        for (AggregateResult ar : leadCounts) {
            String key = (String) ar.get('OwnerId') + '-' + (String) ar.get('Priority__c');
            leadCountMap.put(key, (Integer) ar.get('leadCount'));
        }
        
        // Process each new lead
        for (Lead lead : newLeads) {
            String leadLanguage = lead.Language__c;
            String priority = determineLeadPriority(lead);
            
            if (priority == null) {
                lead.Allow_Assignment_Rules_c__c = false; // No priority leads should not be assigned
                continue; // Skip to next lead
            }
            
            // Assign lead to eligible agent
            assignLeadToAgent(lead, priority, leadLanguage, agentCapacityMap, leadCountMap);
        }
    }
    
    private static String determineLeadPriority(Lead lead) {
        if (lead.Branch__c == 'Computers') {
            return 'P1';
        } else if (lead.Branch__c != null && (lead.College__c == 'College A' || lead.College__c == 'College B')) {
            return 'P2';
        } else if (lead.Branch__c != null) {
            return 'P3';
        }
        return null; // No priority
    }

    private static void assignLeadToAgent(Lead lead, String priority, String leadLanguage, 
                                          Map<String, Agent_Capacity__c> agentCapacityMap, 
                                          Map<String, Integer> leadCountMap) {
        for (String key : agentCapacityMap.keySet()) {
            Agent_Capacity__c agentCapacity = agentCapacityMap.get(key);
            String agentLanguage = agentCapacity.Agent_Language__c;

            // Ensure the agent's language matches the lead's language
            if (agentLanguage == leadLanguage) {
                // Check capacity based on priority
                Integer currentCount = leadCountMap.get(key + '-' + priority);
                Integer maxCapacity = calculateMaxCapacity(agentCapacity, priority);

                if (currentCount == null) {
                    currentCount = 0;
                }

                if (currentCount < maxCapacity) {
                    lead.Allow_Assignment_Rules_c__c = true; // Allow assignment
                    lead.OwnerId = agentCapacity.User__c; // Assign lead to the agent
                    return; // Exit method if assigned
                }
            }
        }

        // If no agent was found, assign to overflow
        lead.Allow_Assignment_Rules_c__c = false;
        lead.OwnerId = 'queueId'; // Replace with actual queue ID for overflow leads
    }

    private static Integer calculateMaxCapacity(Agent_Capacity__c agentCapacity, String priority) {
         switch on priority { // Use 'switch on' in Apex for better readability
             when 'P1' {
                 return (Integer)(agentCapacity.P1_Priority_Percentage__c * agentCapacity.Max_lead_Capacity_Per_Day__c / 100);
                 }
            when 'P2'{
                return (Integer)(agentCapacity.P2_Priority_Percentage__c * agentCapacity.Max_lead_Capacity_Per_Day__c / 100);
                 }
             when 'P3'{
                 return (Integer)(agentCapacity.P3_Priority_Percentage__c * agentCapacity.Max_lead_Capacity_Per_Day__c / 100);
             }
             when else {
                 return null;
                     }
       
    }
    }
}