import { LightningElement, api } from 'lwc';
export default class CustomModal extends LightningElement {
    @api header = 'Modal Title';
    @api isOpen = false;
    closeModal() { this.dispatchEvent(new CustomEvent('close')); }
    handleSave()  { this.dispatchEvent(new CustomEvent('save')); }
}
