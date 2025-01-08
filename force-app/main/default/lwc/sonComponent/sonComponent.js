import { LightningElement } from 'lwc';

export default class SonComponent extends LightningElement {

    meassageToParent;

    inputChangeHandle(e){
                                                                    
        this.meassageToParent=e.target.value;

        const eventName = new CustomEvent('customEventName',{detail:this.meassageToParent});

        this.dispatchEvent(eventName);
        console.log(this.meassageToParent);

    }
}