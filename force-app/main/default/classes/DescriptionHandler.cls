public class DescriptionHandler{
    public static void fieldpopulate(list <Opportunity> newlist){
        for(Opportunity opp:newlist){
            if (opp.Amount > 100000){
                opp.Description = 'Hot opportunity';
            }
             
        }
        
    }

}