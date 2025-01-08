import { LightningElement } from 'lwc';

export default class ParentToChildP extends LightningElement {
    passingData;
    passingDataToC2;
   

    ParentInputHandle(e){
        this.passingData=e.target.value;
       
    }
    PatrentClickHandle(e){
        this.passingDataToC2=this.passingData;
        





    }
}