import { LightningElement, api, track } from 'lwc';
export default class SfDataTable extends LightningElement {
    @api columns = []; @api keyField = 'Id';
    @track _data = []; @track sortedBy; @track sortedDirection = 'asc'; @track filterValue = '';
    @api get data() { return this._data; }
    set data(v) { this._data = v ? [...v] : []; }
    get filteredData() {
        if (!this.filterValue) return this._data;
        const t = this.filterValue.toLowerCase();
        return this._data.filter(r => this.columns.some(c => String(r[c.fieldName]??'').toLowerCase().includes(t)));
    }
    handleSort(e) {
        const {fieldName:f, sortDirection:d} = e.detail; this.sortedBy=f; this.sortedDirection=d;
        this._data = [...this._data].sort((a,b) => (a[f]>b[f]?1:a[f]<b[f]?-1:0)*(d==='asc'?1:-1));
    }
    handleFilter(e) { this.filterValue = e.target.value; }
    handleRowAction(e) { this.dispatchEvent(new CustomEvent('rowaction',{detail:e.detail})); }
}
