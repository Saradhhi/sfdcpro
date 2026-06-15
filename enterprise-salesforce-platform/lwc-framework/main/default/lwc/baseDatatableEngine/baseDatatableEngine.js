import { LightningElement, api } from 'lwc';

export default class BaseDatatableEngine extends LightningElement {
    @api records;
    @api columns;

    get hasData() {
        return Array.isArray(this.records) && this.records.length > 0;
    }
}
