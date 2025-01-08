public class AccountUpdateHandler {
    public static void phoneupdate(List<Account> newList, Map<Id, Account> oldMap) {
        for(Account acc: newlist){
            String  old=oldmap.get(acc.id).phone;
            acc.Description= ''+old+' '+acc.phone;
                
            update acc;
                
        }
    }
}