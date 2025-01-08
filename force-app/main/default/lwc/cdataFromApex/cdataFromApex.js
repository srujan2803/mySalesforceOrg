import { LightningElement,wire } from 'lwc';
import getAcc from '@salesforce/apex/AccountController.getAcc'

export default class CdataFromApex extends LightningElement {
    columnslist=[{label:'id',field:'id'},
                 {label:'Name',field:'Name'}
                ]
    acdata;
    acerror;
    @wire(getAcc)
    wiredAccountController(data,error){
        if(data){
            this.acdata = data;

        }
        else if(error){
            this.acerror = error;
        }

    }


}