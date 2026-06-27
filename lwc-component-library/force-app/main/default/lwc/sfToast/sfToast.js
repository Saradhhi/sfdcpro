import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class SfToast extends LightningElement {
    @api showToast(title,message,variant='success',mode='dismissable') {
        this.dispatchEvent(new ShowToastEvent({title,message,variant,mode}));
    }
    @api success(msg,title='Success') { this.showToast(title,msg,'success'); }
    @api error(msg,title='Error')     { this.showToast(title,msg,'error','sticky'); }
    @api warning(msg,title='Warning') { this.showToast(title,msg,'warning'); }
    @api info(msg,title='Info')       { this.showToast(title,msg,'info'); }
}
