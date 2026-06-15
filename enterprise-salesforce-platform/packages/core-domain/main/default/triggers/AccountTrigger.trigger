trigger AccountTrigger on Account (before insert, before update, after insert) {
    AccountTriggerDomain.handle();
}
