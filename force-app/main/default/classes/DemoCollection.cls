public class DemoCollection {
    
    public static void collectionMethod1(){
        map<string,integer> studentList = new map<string,integer>();
        system.debug(studentList);
        studentList.put('chandu',100);
        studentList.put('john',90);
        studentList.put('deo',40);
        system.debug(studentList);
        integer s = studentList.get('chandu');
        system.debug(s);
        list<String> markList = new list<String>(studentList.keySet());
        system.debug(markList);
        list<Account> namesOfAccount = [select Name,Rating from Account];
        system.debug(namesOfAccount);
        system.debug(namesOfAccount[0]);
        system.debug(namesOfAccount[0].Name);
    }

}