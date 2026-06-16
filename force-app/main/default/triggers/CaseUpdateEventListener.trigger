trigger CaseUpdateEventListener on Case_Update_Event__e (after insert) {
    System.debug('--- PLATFORM EVENT SUBSCRIBER MESSAGE RECEIVED ---');
    for (Case_Update_Event__e eventRecord : Trigger.new) {
        // Enforcing system-mode logging using out-of-the-box streaming telemetry properties
        System.debug('Decoupled event transaction intercepted. Event UUID: ' + eventRecord.EventUuid);
        System.debug('Event Broadcasted By User ID: ' + eventRecord.CreatedById);
    }
}
