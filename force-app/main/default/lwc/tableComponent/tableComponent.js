import { LightningElement, wire, track } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';

export default class TableComponent extends LightningElement {
    @track accounts = {};
    @track isModalOpen = false;
    @track selectedRecordId;
    wiredAccounts;

    columns = [
        { label: 'Account Name', fieldName: 'Name' },
        { label: 'Phone', fieldName: 'Phone' },
        { label: 'Industry', fieldName: 'Industry' },
        {
            type: 'action',
            typeAttributes: {
                rowActions: [
                    { label: 'Edit', iconName: 'utility:edit', name: 'edit' }
                ],
                menuAlignment: 'right'
            }
        }
    ];

    // Wire to get account data and handle both data and error
    @wire(getAccounts)
    wiredGetAccounts(result) {
        this.wiredAccounts = result;
        if (result.data) {
            this.accounts.data = result.data;
            this.accounts.error = undefined;
        } else if (result.error) {
            this.accounts.error = result.error;
            this.accounts.data = undefined;
        }
    }

    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        if (actionName === 'edit') {
            this.selectedRecordId = row.Id;
            this.isModalOpen = true;
        }
    }

    closeModal() {
        this.isModalOpen = false;
        this.selectedRecordId = null;
    }

    handleSuccess() {
        this.isModalOpen = false;
        this.selectedRecordId = null;

        // Refresh the table data
        return refreshApex(this.wiredAccounts).then(() => {
            this.showToast('Success', 'Account updated successfully!', 'success');
        });
    }

    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title,
            message,
            variant
        });
        this.dispatchEvent(event);
    }
}