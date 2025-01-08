import { LightningElement, track } from 'lwc';
import AccountName from '@salesforce/schema/Account.Name';
import AccountPhone from '@salesforce/schema/Account.Phone';
import AccountRating from '@salesforce/schema/Account.Rating';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';



export default class AccountCreateForm extends LightningElement {
  
   objectName = 'Account';
   fields=[AccountName,AccountPhone,AccountRating];
   handleSuccess(event){
    const createdAccount = new ShowToastEvent({title:'success',
          message:'account created success'+event.detail.id,variant:'success'
    });
    this.dispatchEvent(createdAccount);
  }
    handleError(event){
        const notcreatedAccount = new ShowToastEvent({title:'failed',
              message:'account not created',variant:'error'
        });
        this.dispatchEvent(notcreatedAccount);
   }
   

}