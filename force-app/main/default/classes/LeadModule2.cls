public class LeadModule2 {
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
}