import { LightningElement } from 'lwc';

export default class ChildComponent2 extends LightningElement {
    valueToParent;
    
    handleCustomEvent(event){
        this.valueToParent = event.target.value;
        const eventname = new CustomEvent('customeventname',{detail:this.valueToParent});
        this.dispatchEvent(eventname);
    }

    
}