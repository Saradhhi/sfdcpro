public class LogService {

    public static void logInfo(String source, String message) {
        System.debug('INFO: ' + source + ' - ' + message);
    }

    public static void logError(String source, String message) {
        System.debug('ERROR: ' + source + ' - ' + message);
    }
}
