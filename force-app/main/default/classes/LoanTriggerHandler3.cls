public class LoanTriggerHandler3 {
    public static Decimal emiCalculator(Decimal Amount, Decimal InterestRate, double nTenure) {
        double monthInterest = InterestRate / (InterestRate * 100);
        Decimal emi = (Amount * monthInterest * (Math.pow(1 + monthInterest, nTenure))) / ((Math.pow(1 + monthInterest, nTenure)) - 1);
        return emi;
    }

    public static void LoanVerify(List<Loan__c> newlist, Map<Id, Loan__c> oldmap) {
        Map<String, Integer> InterestPercent = new Map<String, Integer> {'Home' => 7, 'Vehicle' => 12, 'Personal' => 14};
        List<Loan_Customer__c> customers = new List<Loan_Customer__c>();

        // Collect customer IDs
        Set<Id> customerIds = new Set<Id>();
        for (Loan__c loan : newlist) {
            if (loan.Select_Customer__c != null) {
                customerIds.add(loan.Select_Customer__c);
            }
        }

        // Query customers once
        Map<Id, Loan_Customer__c> customerMap = new Map<Id, Loan_Customer__c>([SELECT Id, Salary__c FROM Loan_Customer__c WHERE Id IN :customerIds]);

        for (Loan__c loan : newlist) {
            if (loan.LoanAmount__c != null && loan.Loan_Type__c != null && loan.TenureInMonths__c != null) {
                Decimal loanAmount = loan.LoanAmount__c;
                Decimal InterestRate = InterestPercent.get(loan.Loan_Type__c);
                double Tenure = (double)loan.TenureInMonths__c;

                Decimal emi = emiCalculator(loanAmount, InterestRate, Tenure);

                Loan_Customer__c customer = customerMap.get(loan.Select_Customer__c);

                if (customer != null && emi >= (customer.Salary__c) / 2) {
                    loan.addError('Loan EMI is more than half of the customer\'s salary, loan approval not possible.');
                } else if (customer != null) {
                    Loan_Customer__c customerUpdate = new Loan_Customer__c();
                    customerUpdate.Id = loan.Select_Customer__c;
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