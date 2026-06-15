@IsTest
public class TestDataFactory {

    public static Account createAccount() {
        Account acc = new Account(
            Name = 'Test Account',
            Rating = 'Cold',
            Type = 'Prospect'
        );
        insert acc;
        return acc;
    }
}
