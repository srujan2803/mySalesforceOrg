import { LightningElement,wire } from 'lwc';
import { subscribe, MessageContext } from 'lightning/messageService';
import communication_channel from '@salesforce/messageChannel/firstChannel__c';

export default class ComponentB extends LightningElement {

    content1='not yet Received';
    @wire(MessageContext) messageContext;

    subscribe = null;

    connectedCallback() {
        if (!this.subscription) {
            this.subscription = subscribe(this.messageContext, communication_channel, (payload) => {
                this.handleMessage(payload);
            });
        }
    }

    handleMessage(payload) {
    
        this.content1 = payload ? payload.message : 'No message received';
    }

    
}