/**
 * @description Service layer — Account business logic.
 * @author      Vijaya Saradhi Meka
 */
public with sharing class AccountService {
    public static void setIndustryDefault(List<Account> accounts) {
        for (Account a : accounts) if (String.isBlank(a.Industry)) a.Industry = 'Other';
    }
    public static void validatePhone(List<Account> accounts) {
        for (Account a : accounts) if (String.isBlank(a.Phone)) a.addError('Phone is required.');
    }
}
