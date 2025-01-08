import { LightningElement} from 'lwc';

export default class ParentComponent2 extends LightningElement {
    valueFromChild;
    handleChange(event){
       this.valueFromChild = event.detail;
    }
}