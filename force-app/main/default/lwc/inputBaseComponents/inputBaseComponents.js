import { LightningElement, track } from 'lwc';

export default class InputBaseComponents extends LightningElement {
    @track datalist = [
        { id: '1', bike: 'BMW', speed: '100 km/h' ,milage:'20'},
        { id: '2', bike: 'Ducati', speed: '150 km/h',milage:'20' },
        { id: '3', bike: 'Kawasaki', speed: '120 km/h' ,milage:'20'}
    ];

    @track columnlist = [
        { label: "ID", fieldName: "id" },
        { label: "Bike", fieldName: "bike" },
        { label: "Speed", fieldName: "speed" },
        { label: "milage", fieldName: "milage"}
    ];
}