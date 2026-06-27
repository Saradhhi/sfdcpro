/**
 * @description String utility methods reusable across the org.
 * @author      Vijaya Saradhi Meka
 */
public with sharing class StringUtils {
    public static String titleCase(String s) {
        if (String.isBlank(s)) return s;
        List<String> words = s.toLowerCase().split(' ');
        List<String> result = new List<String>();
        for (String w : words) result.add(w.length() > 0 ? w.substring(0,1).toUpperCase() + w.substring(1) : w);
        return String.join(result, ' ');
    }
    public static Boolean isValidEmail(String email) {
        return String.isNotBlank(email) && Pattern.matches('^[a-zA-Z0-9._%+\\-]+@[a-zA-Z0-9.\\-]+\\.[a-zA-Z]{2,}$', email);
    }
    public static String truncate(String s, Integer maxLen) {
        if (String.isBlank(s) || s.length() <= maxLen) return s;
        return s.substring(0, maxLen) + '...';
    }
    public static String sanitize(String s) {
        return String.isBlank(s) ? '' : s.replaceAll('[^a-zA-Z0-9 _\\-]', '');
    }
}
