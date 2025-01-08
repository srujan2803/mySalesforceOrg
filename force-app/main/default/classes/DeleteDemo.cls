public class DeleteDemo {
    public static void method1Delete(){
       Case myCase = [select id ,Account.Phone
                         from Case
                         where CaseNumber = '00001068'
                         LIMIT 1 ];
       String myacc   = myCase.Account.Phone;
       system.debug(myacc);
    }
}