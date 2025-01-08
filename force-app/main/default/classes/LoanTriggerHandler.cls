public class LoanTriggerHandler {
    public static Decimal emiCalculator(Decimal amount, Decimal interestRate, Double tenure) {
        Double monthlyInterestRate = (Double)interestRate / (12 * 100); // Annual interest rate to monthly
        Decimal emi = (amount * monthlyInterestRate * Math.pow(1 + monthlyInterestRate, tenure)) / 
                      ((Math.pow(1 + monthlyInterestRate, tenure)) - 1);
        return emi;
    }

    public static void loanVerify(List<Loan__c> newList, Map<Id, Loan__c> oldMap) {
        Map<String, Integer> interestPercent = new Map<String, Integer>{'Home' => 7, 'Vehicle' => 12, 'Personal' => 14};
        List<Loan_Customer__c> customers = new List<Loan_Customer__c>();

        for (Loan__c loan : newList) {
            if (loan.LoanAmount__c != null && loan.Loan_Type__c != null && loan.TenureInMonths__c != null) {
                System.debug('first');
                Decimal loanAmount   = loan.LoanAmount__c;
                Integer interestRate = interestPercent.get(loan.Loan_Type__c);
                Double tenure        = (Double)loan.TenureInMonths__c;

                Decimal emi = emiCalculator(loanAmount, interestRate, tenure);
                System.debug(emi);

                Loan_Customer__c customer = [SELECT Salary__c FROM Loan_Customer__c WHERE Id = :loan.Select_Customer__c];
                System.debug(customer.Salary__c);

                if (emi >= (customer.Salary__c) / 2) {
                    loan.addError('Sorry we cannot process your loan.the emi is more than the 50% of salary');
                } else {
                    Loan_Customer__c customerUpdate = new Loan_Customer__c();
                    customerUpdate.Id               = loan.Select_Customer__c;
                    customerUpdate.EMI_per_Month__c = emi;
                    customers.add(customerUpdate);
                }
            }
        }

        if (!customers.isEmpty()) {
            update customers;
        }
    }
}