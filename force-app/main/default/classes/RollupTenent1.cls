public class RollupTenent1 {
    public static void rollUpSumCount1(List<Lease__c> newlist, Map<Id, Lease__c> oldmap) {
        Set<Id> TenantIds = new Set<Id>();

        
        if (newlist != null && oldmap == null) {
            for (Lease__c l : newlist) {
                if (l.Tenant__c != null) {
                    TenantIds.add(l.Tenant__c);
                }
            }
        }

        
        if (newlist != null && oldmap != null) {
            for (Lease__c l : newlist) {
                if (l.Tenant__c != null) {
                    Lease__c oldLease = oldmap.get(l.Id);
                    if (l.Rent_Amount__c != oldLease.Rent_Amount__c || l.Tenant__c != oldLease.Tenant__c) {
                        TenantIds.add(l.Tenant__c);
                        TenantIds.add(oldLease.Tenant__c);
                    }
                }
            }
        }

        // Check if only oldmap is provided
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

            List<Tenant__c> tenantList = new List<Tenant__c>();

            for (AggregateResult arrEach : arr) {
                Tenant__c tenant = new Tenant__c();
                tenant.Id = (Id) arrEach.get('Tenant__c');
                tenant.Total_Leases__c = (Integer) arrEach.get('childcount');
                tenant.total__c = (Decimal) arrEach.get('totalAmount');
                tenantList.add(tenant);
            }

            if (!tenantList.isEmpty()) {
                upsert tenantList;
            }
        }
    }
}