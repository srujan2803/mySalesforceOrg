import { LightningElement } from 'lwc';
import leaseAmount from '@salesforce/schema/Lease__c.Rent_Amount__c';

export default class CheckingDepend extends LightningElement {

    leaseA = leaseAmount;

}