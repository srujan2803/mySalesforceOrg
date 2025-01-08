import { LightningElement,wire } from 'lwc';
import accRef from '@salesforce/apex/seachAccountController.getSearchAcc'

export default class SearchAccount extends LightningElement {

    searchkey='';
    handleChange(event){
        this.searchkey=event.target.value;
    }
    @wire(accRef,{accData:'$searchkey'}) accounts;
}