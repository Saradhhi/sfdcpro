import { LightningElement, api, track } from 'lwc';
export default class DataTable extends LightningElement {
    @api columns = [];
    @api data = [];
    @track sortedBy;
    @track sortDirection = 'asc';

    handleSort(event) {
        this.sortedBy = event.detail.fieldName;
        this.sortDirection = event.detail.sortDirection;
        this.dispatchEvent(new CustomEvent('sort', { detail: { field: this.sortedBy, direction: this.sortDirection } }));
    }
}
