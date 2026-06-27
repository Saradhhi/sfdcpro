/** @description Platform-event logging utility | @author Vijaya Saradhi Meka */
public without sharing class LoggerUtil {
    public enum Level { DEBUG, INFO, WARN, ERROR }

    public static void log(Level lvl, String context, String message) {
        System.debug('[' + lvl + '][' + context + '] ' + message);
        // Extend: publish to a Platform Event for persistent logging
    }
    public static void error(String context, Exception e) {
        log(Level.ERROR, context, e.getMessage() + '\n' + e.getStackTraceString());
    }
}
