import { LightningElement, track } from 'lwc';

export default class PersonalPortfolio extends LightningElement {
    @track projects = [
        { id: '1', name: 'BMI Calculator App', tag: 'Core LWC', description: 'Calculates body metrics and delivers clean reactive UI feedback using SLDS state variables.' },
        { id: '2', name: 'Alarm Clock App', tag: 'Asynchronous JS', description: 'Tracks real-time digital clock tracking hooks alongside custom alarm triggering intervals.' },
        { id: '3', name: 'Currency Converter App', tag: 'REST Integration', description: 'Integrates third-party real-time currency exchange rates natively using JavaScript Fetch.' },
        { id: '4', name: 'Weather App', tag: 'REST Integration', description: 'Fetches real-time environmental metrics mapped dynamically by city location text parameters.' },
        { id: '5', name: 'Employee Survey App', tag: 'Forms & Data', description: 'Captures detailed organizational feedback with embedded type checking and field validations.' },
        { id: '6', name: 'Note-Taking App', tag: 'State Arrays', description: 'Maintains client-side state storage array modifications for custom runtime note tracking.' },
        { id: '7', name: 'Personal Portfolio Site', tag: 'UI Architecture', description: 'This central application portal designed to display and showcase my entire Salesforce skillset.' },
        { id: '8', name: 'AI Chef (Bonus Project)', tag: 'Salesforce AI', description: 'Leverages Prompt Builder, custom Apex logic, and LWC to generate recipes from user inputs.' }
    ];
}
