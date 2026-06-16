public with sharing class ExceptionHandler {
    
    public class IntegrationException extends Exception {}
    public class ValidationException extends Exception {}

    public static void logException(Exception ex, String sourceContext) {
        System.debug(LoggingLevel.ERROR, '--- ENTERPRISE EXCEPTION LOGGED ---');
        System.debug(LoggingLevel.ERROR, 'Source Context: ' + sourceContext);
        System.debug(LoggingLevel.ERROR, 'Type: ' + ex.getTypeName());
        System.debug(LoggingLevel.ERROR, 'Message: ' + ex.getMessage());
        System.debug(LoggingLevel.ERROR, 'StackTrace: ' + ex.getStackTraceString());
    }
}
