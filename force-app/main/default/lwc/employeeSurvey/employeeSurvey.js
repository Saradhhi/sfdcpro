import { LightningElement, track } from 'lwc';

export default class EmployeeSurvey extends LightningElement {
    @track employeeName = '';
    @track department = '';
    @track satisfactionScore = 5;
    @track feedbackComments = '';
    @track isSubmitted = false;

    deptOptions = [
        { label: 'Engineering / Product', value: 'Engineering' },
        { label: 'Sales / Marketing', value: 'Sales' },
        { label: 'Customer Success / Support', value: 'Support' },
        { label: 'Human Resources / Operations', value: 'HR' }
    ];

    handleInputChange(event) {
        const { name, value } = event.target;
        this[name] = value;
    }

    handleSubmit() {
        // Validate fields before submitting
        const allValid = [
            ...this.template.querySelectorAll('lightning-input, lightning-radio-group')
        ].reduce((validSoFar, inputFields) => {
            inputFields.reportValidity();
            return validSoFar && inputFields.checkValidity();
        }, true);

        if (allValid) {
            this.isSubmitted = true;
            // Portfolio Context Note: In a production org deployment, you can import 
            // createRecord from 'lightning/uiRecordApi' to save this right into a Custom Object.
            console.log('Survey Submitted Natively:', {
                Name: this.employeeName,
                Department: this.department,
                Score: this.satisfactionScore,
                Comments: this.feedbackComments
            });
        }
    }

    resetForm() {
        this.employeeName = '';
        this.department = '';
        this.satisfactionScore = 5;
        this.feedbackComments = '';
        this.isSubmitted = false;
    }
}
