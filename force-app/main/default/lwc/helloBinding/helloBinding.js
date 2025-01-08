import { LightningElement ,track} from 'lwc';

export default class HelloBinding extends LightningElement {
    @track gretting = 'noname';
    handlechange(event){
        this.gretting=event.target.value;
    }

}