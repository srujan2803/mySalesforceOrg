import { LightningElement, api } from 'lwc';
import { deleteRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

export default class DeleteAccount extends NavigationMixin(LightningElement) {
    @api recordId;

    handleDeleteAccount() {
        const recordId = this.recordId; // Store the recordId before deletion

        deleteRecord(recordId)
            .then(() => {
                this.showToast('Success', 'Account deleted successfully!', 'success');

                // Clear the recordId to avoid referencing a deleted record
                this.recordId = null;

                // Navigate to the Salesforce app home page
                this.navigateToAppHome();
            })
            .catch(error => {
                this.showToast('Error', 'Error deleting account: ' + error.body.message, 'error');
            });
    }

    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
        });
        this.dispatchEvent(event);
    }

    navigateToAppHome() {
        this[NavigationMixin.Navigate]({
            type: 'standard__app',
            attributes: {
                appTarget: 'standard__LightningSales',
            },
        });
    }
}