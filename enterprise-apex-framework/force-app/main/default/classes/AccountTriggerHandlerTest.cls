@IsTest
private class AccountTriggerHandlerTest {
    @IsTest static void testInsert_SetsIndustryDefault() {
        Account a = new Account(Name='Test',Phone='555-1234');
        Test.startTest(); insert a; Test.stopTest();
        System.assertEquals('Other',[SELECT Industry FROM Account WHERE Id=:a.Id].Industry);
    }
    @IsTest static void testInsert_MissingPhone_Fails() {
        try { insert new Account(Name='No Phone'); System.assert(false); }
        catch (DmlException e) { System.assert(e.getMessage().contains('Phone')); }
    }
    @IsTest static void testBulk_200Records() {
        List<Account> bulk = new List<Account>();
        for(Integer i=0;i<200;i++) bulk.add(new Account(Name='Bulk '+i,Phone='555-'+i));
        Test.startTest(); insert bulk; Test.stopTest();
        System.assertEquals(200,[SELECT COUNT() FROM Account WHERE Name LIKE 'Bulk%']);
    }
}
