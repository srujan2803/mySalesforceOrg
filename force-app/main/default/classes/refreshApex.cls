public with sharing class refreshApex {
    @AuraEnabled (cacheable=true)
    Public static List<Contact> getContactsWithEmailAndAccount(){
        return [Select id, Name, FirstName, LastName, Email, Account.Name, Phone from contact where Email!=null AND AccountId != null];
    }
}