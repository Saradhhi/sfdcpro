@isTest
private class AIChefControllerTest {

    @isTest
    static void testGenerateRecipeSuccess() {
        // 1. Arrange test parameters
        String testIngredients = 'Eggs, Tomatoes, Cheese';

        // 2. Act by invoking the controller method natively
        Test.startTest();
        String resultRecipe = AIChefController.generateRecipe(testIngredients);
        Test.stopTest();

        // 3. Assert that results match expected design outputs
        System.assertNotEquals(null, resultRecipe, 'The recipe response should not be null.');
        System.assert(resultRecipe.contains('Eggs, Tomatoes, Cheese'), 'The recipe readout should reflect the input ingredients.');
        System.assert(resultRecipe.contains('Gourmet Freestyle Skillet'), 'The recipe should output the default portfolio template title.');
    }

    @isTest
    static void testGenerateRecipeEmptyInputException() {
        // 1. Arrange an empty argument string to trigger validation logic
        String emptyIngredients = '   ';
        Boolean exceptionCaught = false;

        // 2. Act within a try/catch mapping matrix
        Test.startTest();
        try {
            AIChefController.generateRecipe(emptyIngredients);
        } catch (AuraHandledException e) {
            exceptionCaught = true;
            System.assert(e.getMessage().contains('Ingredients list cannot be empty'), 'The error message must communicate input validation failure.');
        }
        Test.stopTest();

        // 3. Assert that the validation rule path executed cleanly
        System.assertEquals(true, exceptionCaught, 'An AuraHandledException should have been thrown for an empty string.');
    }
}
