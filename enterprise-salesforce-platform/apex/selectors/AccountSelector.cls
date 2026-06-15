public class AccountSelector {

    public static List<Account> getActiveAccounts(Set<Id> ids) {
        return [
            SELECT Id, Name, Rating, Type, AnnualRevenue
            FROM Account
            WHERE Id IN :ids
        ];
    }
}
