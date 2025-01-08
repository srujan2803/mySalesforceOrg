public class CalculatePrice {
    string store;
    string customer;
    //constructer
    public CalculatePrice(string store,string customer){
        this.store    = store;
        this.customer = customer;
       
    }
    
    //method used to calculate the final price
    public void calculateFinalPrice(integer price,integer discount){
        double discountAmount = price * (discount / 100.0);
        double finalPrice = price - discountAmount;
        string formatString = string.format('hello {0} your finalprice after discount ₹ {1} thnks for visiting store:{2}',new list<object>{customer,finalPrice,store});
        system.debug(formatString);
        
        
    }
    
}