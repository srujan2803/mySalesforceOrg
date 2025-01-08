public class ProjectTriggerHandler {
    public static void ProjectStatuspop(list<projects__c> newlist){
        for(projects__c project:newlist){
            if(project.Pstatus__c == null){
              project.Pstatus__c = 'new'; 
            }
        }
    }

}