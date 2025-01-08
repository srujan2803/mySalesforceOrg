import { LightningElement } from 'lwc';


export default class Cfirst extends LightningElement {
    message='new world';
    disc;
    list;
    handleClick(){
       this.disc='today task';
       this.list =['eat','code','slepp'];
       this.template.querySelector('#firstheading').style.color='red';

    }
}