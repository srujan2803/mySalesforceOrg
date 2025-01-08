import { LightningElement } from 'lwc';

export default class FatherComponent extends LightningElement {

    messagefromchild;
    
    
    handleChildEvent(event){
       this.messagefromchild=event.detail;
       console.log(this.messagefromchild);
    }
  
}