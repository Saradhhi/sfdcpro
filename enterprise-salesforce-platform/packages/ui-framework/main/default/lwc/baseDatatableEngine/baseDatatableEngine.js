import { LightningElement, api, track } from 'lwc';

export default class BaseDatatableEngine extends LightningElement {
    @api columns = [];
    @api data = [];
    @track selectedRows = [];

    handleRowSelection(event) {
        this.selectedRows = event.detail.selectedRows;
        const selectedEvent = new CustomEvent('rowselection', {
            detail: { selectedRows: this.selectedRows }
        });
        this.dispatchEvent(selectedEvent);
    }
}
