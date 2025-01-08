public class AssignLeadTest2 {

    public static String PrepopulatePriority(String Branch, String CollageName) {
        String LeadBranch = Branch;
        String LeadCollage = CollageName;

        List<String> P1Branch = new List<String>{'CSE', 'IT', 'AI', 'Machine Learning'};
        List<String> P2Branch = new List<String>{'Mechanical', 'Civil', 'EEE'};
        List<String> P2Collage = new List<String>{'College A', 'College B'};

        if (P1Branch.contains(LeadBranch)) {
            return 'P1';
        } else if (P2Branch.contains(LeadBranch) && P2Collage.contains(LeadCollage)) {
            return 'P2';
        } else {
            return 'P3';
        }
    }

    public static List<Object> getPriorityCount(String agentLanguage, String priority) {
        List<Agent_Capacity__c> agentMaxAndPriority = [
            SELECT User__c, Max_lead_Capacity_Per_Day__c,
                   P1_Priority_Percentage__c, P2_Priority_Percentage__c,
                   P3_Priority_Percentage__c, Agent_Language__c
            FROM Agent_Capacity__c
        ];

        Map<Id, Map<String, Decimal>> agentCapacityMap = new Map<Id, Map<String, Decimal>>();
        Map<String, Id> agentLanguageMap = new Map<String, Id>();

        for (Agent_Capacity__c agentCapacity : agentMaxAndPriority) {
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
            agentLanguageMap.put(agentCapacity.Agent_Language__c, agentCapacity.User__c);
        }

        Id userId = agentLanguageMap.get(agentLanguage);

        if (userId != null && agentCapacityMap.containsKey(userId)) {
            Map<String, Decimal> capacityDetails = agentCapacityMap.get(userId);
            Decimal priorityCount = capacityDetails.get(priority + 'Capacity');

            return new List<Object>{userId, priorityCount};
        }

        return new List<Object>();
    }

    public static void AssignLead(List<Lead> newLeads) {
        // Map to track counts within the transaction for each agent and priority
        Map<String, Integer> transactionLeadCountMap = new Map<String, Integer>();

        // Retrieve counts of today's leads for each agent and priority
        Map<Id, Map<String, Integer>> todayLeadCounts = new Map<Id, Map<String, Integer>>();
        for (AggregateResult ar : [
                SELECT OwnerId, Priority__c, COUNT(Id) leadCount
                FROM Lead
                WHERE CreatedDate = TODAY
                GROUP BY OwnerId, Priority__c
        ]) {
            Id ownerId = (Id) ar.get('OwnerId');
            String priority = (String) ar.get('Priority__c');
            Integer count = (Integer) ar.get('leadCount');

            if (!todayLeadCounts.containsKey(ownerId)) {
                todayLeadCounts.put(ownerId, new Map<String, Integer>());
            }
            todayLeadCounts.get(ownerId).put(priority, count);
        }

        // Process each lead in the list
        for (Lead nlead : newLeads) {
            // Determine priority
            String priority = PrepopulatePriority(nlead.Branch__c, nlead.College__c);
            nlead.Priority__c = priority;

            // Get agent capacity based on language and priority
            List<Object> AgentPriorityCount = getPriorityCount(nlead.Language__c, priority);

            if (AgentPriorityCount.size() >= 2) {
                Id agentId = (Id) AgentPriorityCount[0];
                Decimal maxPriorityCount = (Decimal) AgentPriorityCount[1];

                // Combine today's lead count with in-transaction count
                String key = agentId + '-' + priority;
                Integer todayLeadCount = todayLeadCounts.containsKey(agentId) && todayLeadCounts.get(agentId).containsKey(priority)
                                         ? todayLeadCounts.get(agentId).get(priority)
                                         : 0;
                Integer inTransactionCount = transactionLeadCountMap.containsKey(key) ? transactionLeadCountMap.get(key) : 0;
                Integer totalLeadCount = todayLeadCount + inTransactionCount;

                // Check if agent can take more leads
                if (totalLeadCount < maxPriorityCount) {
                    nlead.OwnerId = agentId;
                    transactionLeadCountMap.put(key, inTransactionCount + 1); // Update transaction map
                } else {
                    // If over capacity, assign to a queue or fallback user
                    nlead.OwnerId = '00GdM000007bKjh';
                }
            }
        }
    }
}