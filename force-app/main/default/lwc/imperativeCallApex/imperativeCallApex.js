import { LightningElement, track } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController1.getAccounts';

export default class ImperativeApexCallWithDataTable extends LightningElement {
    @track accounts;
    @track error;

    
    columns = [
        { label: 'Id', fieldName: 'Id' },
        { label: 'Name', fieldName: 'Name' }
    ];

    handleGetAccounts() {
        getAccounts()
            .then((result) => {
                this.accounts = result;
                this.error = undefined;
            })
            .catch((error) => {
                this.error = error;
                this.accounts = undefined;
            });
    }
    
}