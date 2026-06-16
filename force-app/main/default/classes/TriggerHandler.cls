public virtual class TriggerHandler {
    private static Set<String> bypassedHandlers = new Set<String>();
    @TestVisible protected LoopCount forwardLoopCount;
    @TestVisible protected TriggerContext context;

    public enum TriggerContext { BEFORE_INSERT, BEFORE_UPDATE, BEFORE_DELETE, AFTER_INSERT, AFTER_UPDATE, AFTER_DELETE, AFTER_UNDELETE }

    public TriggerHandler() {
        this.setTriggerContext();
        this.forwardLoopCount = new LoopCount();
    }

    public void run() {
        if (bypassedHandlers.contains(String.valueOf(this).split(':')[0])) { return; }
        if (this.context == TriggerContext.BEFORE_INSERT) { this.beforeInsert(); }
        else if (this.context == TriggerContext.BEFORE_UPDATE) { this.beforeUpdate(); }
        else if (this.context == TriggerContext.AFTER_INSERT) { this.afterInsert(); }
        else if (this.context == TriggerContext.AFTER_UPDATE) { this.afterUpdate(); }
    }

    public static void bypass(String handlerName) { bypassedHandlers.add(handlerName); }
    public static void clearBypass(String handlerName) { bypassedHandlers.remove(handlerName); }

    @TestVisible private void setTriggerContext() {
        if (Trigger.isBefore && Trigger.isInsert) { this.context = TriggerContext.BEFORE_INSERT; }
        else if (Trigger.isBefore && Trigger.isUpdate) { this.context = TriggerContext.BEFORE_UPDATE; }
        else if (Trigger.isAfter && Trigger.isInsert) { this.context = TriggerContext.AFTER_INSERT; }
        else if (Trigger.isAfter && Trigger.isUpdate) { this.context = TriggerContext.AFTER_UPDATE; }
    }

    protected virtual void beforeInsert() {}
    protected virtual void beforeUpdate() {}
    protected virtual void afterInsert() {}
    protected virtual void afterUpdate() {}

    public class LoopCount {
        private Integer max;
        private Integer count;
        public LoopCount() { this.max = 5; this.count = 0; }
        public void increment() { this.count++; if (this.count > this.max) { throw new TriggerHandlerException('Maximum loop count execution limit reached.'); } }
    }
    public class TriggerHandlerException extends Exception {}
}
