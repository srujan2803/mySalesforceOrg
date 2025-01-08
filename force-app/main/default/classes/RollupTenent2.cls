public class RollupTenent2 {
    public static void rollUpSumCount2(List<Lease__c> newlist, Map<Id, Lease__c> oldmap) {
        Set<Id> TenantIds = new Set<Id>();

        // insertion
        if (newlist != null && oldmap == null) {
            for (Lease__c l : newlist) {
                if (l.Tenant__c != null) {
                    TenantIds.add(l.Tenant__c);
                }
            }
        }

        // updation
        if (newlist != null && oldmap != null) {
            for (Lease__c l : newlist) {
                Lease__c oldLease = oldmap.get(l.Id);
                if (l.Tenant__c != null) {
                    if (l.Rent_Amount__c != oldLease.Rent_Amount__c && l.Tenant__c == oldLease.Tenant__c) {
                        TenantIds.add(l.Tenant__c);
                    }
                }
                if (oldLease.Tenant__c != null && l.Tenant__c != oldLease.Tenant__c) {
                    TenantIds.add(oldLease.Tenant__c);
                }
            }
        }

        // for deletions
        if (newlist == null && oldmap != null) {
            for (Lease__c l : oldmap.values()) {
                if (l.Tenant__c != null) {
                    TenantIds.add(l.Tenant__c);
                }
            }
        }

        if (!TenantIds.isEmpty()) {
            List<AggregateResult> arr = [
                SELECT Tenant__c,
                       SUM(Rent_Amount__c) totalAmount,
                       COUNT(Id) childcount
                FROM Lease__c
                WHERE Tenant__c IN :TenantIds
                GROUP BY Tenant__c
            ];
           

            Map<Id, AggregateResult> tenantAggregateMap = new Map<Id, AggregateResult>();
            for (AggregateResult ar : arr) {
                tenantAggregateMap.put((Id)ar.get('Tenant__c'), ar);
            }
            

            List<Tenant__c> tenantList = new List<Tenant__c>();

            for (Id tenantId : TenantIds) {
                Tenant__c tenant = new Tenant__c();
                tenant.Id = tenantId;
                
                if (tenantAggregateMap.containsKey(tenantId)) {
                    AggregateResult ar = tenantAggregateMap.get(tenantId);
                    tenant.Total_Leases__c = (Integer) ar.get('childcount');
                    tenant.total__c = (Decimal) ar.get('totalAmount');
                } else {
                    tenant.Total_Leases__c = 0;
                    tenant.total__c = 0;
                }

                tenantList.add(tenant);
            }

            if (!tenantList.isEmpty()) {
                upsert tenantList;
            }
        }
    }
}