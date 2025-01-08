import { LightningElement, api } from 'lwc';

export default class RefreshTableAndModelComponentB extends LightningElement {
    @api contactrecid;

    handleSuccess() {
        const closeEvent = new CustomEvent('toclosepopup');
        this.dispatchEvent(closeEvent);
    }

    handleCancel() {
        const closeEvent = new CustomEvent('toclosepopup');
        this.dispatchEvent(closeEvent);
    }
}