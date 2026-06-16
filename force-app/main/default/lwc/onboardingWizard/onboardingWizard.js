import { LightningElement, track } from 'lwc';
export default class OnboardingWizard extends LightningElement {
    @track currentStep = '1';
    @track masterPayload = { accountInfo: {}, contactInfo: {}, billingSetup: {} };
}
