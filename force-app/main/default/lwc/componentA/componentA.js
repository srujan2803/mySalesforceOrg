import { LightningElement,wire } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import communication_channel from '@salesforce/messageChannel/firstChannel__c';

export default class ComponentA extends LightningElement {


    @wire(MessageContext) messageContext;

    content='';
    handleChange(event){
        this.content=event.target.value;
    }
    handleClick(){
        const payload = {message:this.content};
        publish(this.messageContext,communication_channel,payload);
    }





}