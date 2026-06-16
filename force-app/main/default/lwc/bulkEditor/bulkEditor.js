import { LightningElement, wire, track } from 'lwc';
import getDraftOrders from '@salesforce/apex/OrderService.getDraftOrders';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class BulkEditor extends LightningElement {
    @track draftValues = [];
    @wire(getDraftOrders) orders;

    async handleSave(event) {
        const recordInputs = event.detail.draftValues.slice().map(draft => {
            const fields = Object.assign({}, draft);
            return { fields };
        });

        try {
            const promises = recordInputs.map(input => updateRecord(input));
            await Promise.all(promises);
            this.dispatchEvent(new ShowToastEvent({ title: 'Success', message: 'Orders updated', variant: 'success' }));
            this.draftValues = [];
        } catch (error) {
            console.error('Error updating records: ', error);
        }
    }
}
