/**
 * @description Base Trigger Handler — extend this for every SObject trigger.
 * @author      Vijaya Saradhi Meka
 */
public virtual class TriggerHandler {
    private Boolean isTriggerExecuting;
    private static Map<String,Integer> loopCount = new Map<String,Integer>();
    private static final Integer MAX_LOOPS = 5;

    public TriggerHandler() { this.isTriggerExecuting = Trigger.isExecuting; }

    public void run() {
        if (!isTriggerExecuting) throw new TriggerHandlerException('Called outside Trigger context');
        String name = getHandlerName();
        loopCount.put(name, (loopCount.get(name) ?? 0) + 1);
        if (loopCount.get(name) > MAX_LOOPS) throw new TriggerHandlerException('Max loops exceeded: ' + name);
        if (Trigger.isBefore) {
            if (Trigger.isInsert)   beforeInsert();
            if (Trigger.isUpdate)   beforeUpdate();
            if (Trigger.isDelete)   beforeDelete();
            if (Trigger.isUndelete) beforeUndelete();
        } else {
            if (Trigger.isInsert)   afterInsert();
            if (Trigger.isUpdate)   afterUpdate();
            if (Trigger.isDelete)   afterDelete();
            if (Trigger.isUndelete) afterUndelete();
        }
    }

    protected virtual void beforeInsert()   {}
    protected virtual void beforeUpdate()   {}
    protected virtual void beforeDelete()   {}
    protected virtual void beforeUndelete() {}
    protected virtual void afterInsert()    {}
    protected virtual void afterUpdate()    {}
    protected virtual void afterDelete()    {}
    protected virtual void afterUndelete()  {}

    private String getHandlerName() {
        return String.valueOf(this).substringBefore(':');
    }
    public class TriggerHandlerException extends Exception {}
}
