import { LightningElement, api } from 'lwc';
export default class SfModal extends LightningElement {
    @api header = 'Modal Title'; @api size = 'medium';
    get modalClass() { return `slds-modal slds-fade-in-open slds-modal_${this.size}`; }
    handleClose() { this.dispatchEvent(new CustomEvent('close')); }
    handleSave()  { this.dispatchEvent(new CustomEvent('save')); }
}
