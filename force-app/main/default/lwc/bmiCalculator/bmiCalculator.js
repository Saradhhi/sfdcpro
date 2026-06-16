import { LightningElement, track } from 'lwc';

export default class BmiCalculator extends LightningElement {
    @track weight = '';
    @track height = '';
    @track bmiResult = '';
    @track bmiStatus = '';
    @track resultClass = '';

    handleWeightChange(event) {
        this.weight = parseFloat(event.target.value);
    }

    handleHeightChange(event) {
        this.height = parseFloat(event.target.value);
    }

    get isInvalidInput() {
        return !this.weight || !this.height || this.weight <= 0 || this.height <= 0;
    }

    calculateBMI() {
        if (this.isInvalidInput) return;

        const bmi = (this.weight / (this.height * this.height)).toFixed(2);
        this.bmiResult = bmi;

        if (bmi < 18.5) {
            this.bmiStatus = 'Underweight';
            this.resultClass = 'slds-text-color_weak slds-text-font_bold';
        } else if (bmi >= 18.5 && bmi < 25) {
            this.bmiStatus = 'Normal weight';
            this.resultClass = 'slds-text-color_success slds-text-font_bold';
        } else if (bmi >= 25 && bmi < 30) {
            this.bmiStatus = 'Overweight';
            this.resultClass = 'slds-text-color_error slds-text-font_bold';
        } else {
            this.bmiStatus = 'Obese';
            this.resultClass = 'slds-text-color_error slds-text-font_bold slds-text-heading_small';
        }
    }
}
