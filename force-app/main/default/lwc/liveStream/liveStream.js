import { LightningElement, track } from 'lwc'; 
import { subscribe } from 'lightning/empApi'; 
export default class LiveStream extends LightningElement { 
    channelName = '/event/Case_Update_Event__e'; 
    eventLogs = []; 
} 
