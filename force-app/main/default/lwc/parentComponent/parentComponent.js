import { LightningElement ,api} from 'lwc';

export default class ParentComponent extends LightningElement {

    entedtext;

   handlingChange(event){
    this.entedtext = event.target.value;
   }
}