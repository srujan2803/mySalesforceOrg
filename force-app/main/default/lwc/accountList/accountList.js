import { LightningElement,wire } from 'lwc';
import getAcc from '@salesforce/apex/AccountController.getAcc'


export default class AccountList extends LightningElement {
    columns = [{label:"Id",fieldName:"Id"},
               {label:"Name",fieldName:"Name"}
    ];
    accData;
    accError;
    @wire(getAcc)
    

    wiredAccountController({data,error}){
        if(data){
            this.accData = data;

        }
        else if(error){
            this.accError = error;
        }

        
    }

    
}