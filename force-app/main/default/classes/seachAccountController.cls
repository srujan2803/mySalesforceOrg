public class seachAccountController {
    @AuraEnabled(Cacheable=true)
    public static list<Account> getSearchAcc(String accData){

     String searchKey = '%'+accData+'%';
     
      list<Account> accList = [select Name,Rating from Account where Name like :searchKey Limit 10];

      return accList;
      

    }
}