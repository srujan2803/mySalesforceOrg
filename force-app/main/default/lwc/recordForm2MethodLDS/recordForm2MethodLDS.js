import { LightningElement } from 'lwc';
import ObjectRef from '@salesforce/schema/Account';
import accName from '@salesforce/schema/Account.Name';
import accRating from '@salesforce/schema/Account.Rating';
import { createRecord } from 'lightning/uiRecordApi';
import { NavigationMixin } from 'lightning/navigation';

export default class RecordForm2MethodLDS extends NavigationMixin(LightningElement) {

    accNameInput;
    accRatingInput;

    handleChange(event){

        if(event.target.label=="Account Name")
            this.accNameInput=event.target.value;
        if(event.target.label=="Account Rating")
            this.accRatingInput=event.target.value;





    }

    handleClick(){
        const fields ={};
        fields[accName.fieldApiName]=this.accNameInput;
        fields[accRating.fieldApiName]=this.accRatingInput;

        const recordInput ={apiName:ObjectRef.objectApiName,fields};
        createRecord(recordInput);


    this[NavigationMixin.Navigate]({
        type:'standard__recordPage',
        attributes:{
            recordId:'ObjectRef.id',
            objectApiName:'Account',
            actionName:'view'
        }

    })

    }

}