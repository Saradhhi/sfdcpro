public class AccountService {

    public static void applyRules(List<Account> accounts) {
        for (Account acc : accounts) {
            if (String.isBlank(acc.Rating)) {
                acc.Rating = 'Warm';
            }
            if (String.isBlank(acc.Type)) {
                acc.Type = 'Prospect';
            }
            if (acc.AnnualRevenue == null) {
                acc.AnnualRevenue = 0;
            }
        }
    }
}
