/**
 * @description Date/DateTime utility methods.
 * @author      Vijaya Saradhi Meka
 */
public with sharing class DateUtils {
    public static Integer businessDaysBetween(Date startDate, Date endDate) {
        Integer count = 0;
        Date d = startDate;
        while (d <= endDate) {
            DateTime dt = DateTime.newInstance(d, Time.newInstance(0,0,0,0));
            String day = dt.format('EEEE');
            if (day != 'Saturday' && day != 'Sunday') count++;
            d = d.addDays(1);
        }
        return count;
    }
    public static Date firstDayOfMonth(Date d)  { return Date.newInstance(d.year(), d.month(), 1); }
    public static Date lastDayOfMonth(Date d)   { return firstDayOfMonth(d).addMonths(1).addDays(-1); }
    public static Boolean isWeekend(Date d) {
        String day = DateTime.newInstance(d, Time.newInstance(0,0,0,0)).format('EEEE');
        return day == 'Saturday' || day == 'Sunday';
    }
}
