import { LightningElement, track } from 'lwc';

export default class CurrencyConverter extends LightningElement {
    @track amount = 1;
    @track fromCurrency = 'USD';
    @track toCurrency = 'EUR';
    @track conversionResult = '';

    currencyOptions = [
        { label: 'USD - US Dollar', value: 'USD' },
        { label: 'EUR - Euro', value: 'EUR' },
        { label: 'GBP - British Pound', value: 'GBP' },
        { label: 'INR - Indian Rupee', value: 'INR' },
        { label: 'AUD - Australian Dollar', value: 'AUD' },
        { label: 'CAD - Canadian Dollar', value: 'CAD' },
        { label: 'SGD - Singapore Dollar', value: 'SGD' }
    ];

    handleAmountChange(event) {
        this.amount = event.target.value;
    }

    handleCurrencyChange(event) {
        const { name, value } = event.target;
        if (name === 'fromCurrency') this.fromCurrency = value;
        if (name === 'toCurrency') this.toCurrency = value;
    }

    get isInvalidAmount() {
        return !this.amount || this.amount <= 0;
    }

    async convertCurrency() {
        if (this.isInvalidAmount) return;

        const url = `https://open.er-api.com/v6/latest/${this.fromCurrency}`;
        try {
            const response = await fetch(url);
            if (response.ok) {
                const data = await response.json();
                const rate = data.rates[this.toCurrency];
                this.conversionResult = (this.amount * rate).toFixed(2);
            } else {
                console.error('Error reaching currency API endpoints');
            }
        } catch (error) {
            console.error('Network execution failure caught: ', error);
        }
    }
}
