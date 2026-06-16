import { LightningElement, track } from 'lwc';

export default class AlarmClock extends LightningElement {
    @track currentTime = '';
    @track selectedHour = '';
    @track selectedMinute = '';
    @track selectedPeriod = '';
    
    @track alarmTime = '';
    @track isAlarmSet = false;
    @track isAlarmTriggered = false;

    hourOptions = [];
    minuteOptions = [];
    periodOptions = [
        { label: 'AM', value: 'AM' },
        { label: 'PM', value: 'PM' }
    ];

    connectedCallback() {
        this.generateDropdownOptions();
        this.startClock();
    }

    startClock() {
        setInterval(() => {
            const date = new Date();
            let hours = date.getHours();
            const minutes = String(date.getMinutes()).padStart(2, '0');
            const seconds = String(date.getSeconds()).padStart(2, '0');
            const period = hours >= 12 ? 'PM' : 'AM';

            hours = hours % 12;
            hours = hours ? hours : 12; // convert 0 to 12
            const formattedHours = String(hours).padStart(2, '0');

            this.currentTime = `${formattedHours}:${minutes}:${seconds} ${period}`;

            // Check if alarm matches down to the minute
            if (this.isAlarmSet && `${formattedHours}:${minutes} ${period}` === this.alarmTime) {
                this.isAlarmTriggered = true;
            }
        }, 1000);
    }

    generateDropdownOptions() {
        for (let i = 1; i <= 12; i++) {
            const val = String(i).padStart(2, '0');
            this.hourOptions.push({ label: val, value: val });
        }
        for (let i = 0; i < 60; i += 5) { // 5 minute increments for clean UI
            const val = String(i).padStart(2, '0');
            this.minuteOptions.push({ label: val, value: val });
        }
    }

    handleTimeChange(event) {
        const { name, value } = event.target;
        if (name === 'hour') this.selectedHour = value;
        if (name === 'minute') this.selectedMinute = value;
        if (name === 'period') this.selectedPeriod = value;
    }

    get isInvalidSelection() {
        return !this.selectedHour || !this.selectedMinute || !this.selectedPeriod;
    }

    setAlarm() {
        this.alarmTime = `${this.selectedHour}:${this.selectedMinute} ${this.selectedPeriod}`;
        this.isAlarmSet = true;
    }

    clearAlarm() {
        this.isAlarmSet = false;
        this.isAlarmTriggered = false;
        this.alarmTime = '';
        this.selectedHour = '';
        this.selectedMinute = '';
        this.selectedPeriod = '';
    }
}
