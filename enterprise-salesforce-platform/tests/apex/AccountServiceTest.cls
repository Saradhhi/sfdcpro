@IsTest
public class AccountServiceTest {

    @IsTest static void testRulesApplyDefaults() {
        Account acc = TestDataFactory.createAccount();
        acc.Rating = null;

        Test.startTest();
        AccountService.applyRules(new List<Account>{ acc });
        Test.stopTest();

        System.assertEquals('Warm', acc.Rating);
    }
}
