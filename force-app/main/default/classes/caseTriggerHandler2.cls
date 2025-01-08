public class caseTriggerHandler2 {
    
    public static void caseIdUpdate(List<Case> newlist, Map<Id, Case> oldmap) {
        List<Account> accToUpdate = new List<Account>();
        List<Account> accToClear = new List<Account>();

        for (Case myCase : newlist) {
            if (myCase.CaseNumber != null && myCase.AccountId != null) {
                // Update the Account with the new CaseNumber
                Account ac = new Account();
                ac.Id = myCase.AccountId;
                ac.Latest_Case_Number__c = myCase.CaseNumber;
                accToUpdate.add(ac);
                
                // Clear the Latest_Case_Number__c for the old Account, if it exists
                Case oldCase = oldmap.get(myCase.Id);
                if (oldCase != null && oldCase.AccountId != null) {
                    Account ac1 = new Account();
                    ac1.Id = oldCase.AccountId;
                    ac1.Latest_Case_Number__c = ' ';
                    accToClear.add(ac1);
                }
            }
        }

        if (!accToUpdate.isEmpty()) {
            update accToUpdate;
        }

        if (!accToClear.isEmpty()) {
            update accToClear;
        }
    }

    public static void caseIdUpdateDelete(List<Case> oldlist) {
        List<Account> accToClear = new List<Account>();

        for (Case ca : oldlist) {
            if (ca.CaseNumber != null && ca.AccountId != null) {
                Account ac2 = new Account();
                ac2.Id = ca.AccountId;
                ac2.Latest_Case_Number__c = ' ';
                accToClear.add(ac2);
            }
        }

        if (!accToClear.isEmpty()) {
            update accToClear; // Use update instead of upsert since you are only updating existing records
        }
    
}


}