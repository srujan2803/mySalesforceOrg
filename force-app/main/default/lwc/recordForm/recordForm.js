import { LightningElement } from 'lwc';
import accountName from '@salesforce/schema/Account.Name'
import accountRating from '@salesforce/schema/Account.Rating'

export default class RecordForm extends LightningElement {

    accountObj='Account';
    feilds=[accountName,accountRating];
    

}