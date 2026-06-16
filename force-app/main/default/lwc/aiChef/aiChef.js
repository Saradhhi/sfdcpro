import { LightningElement, track } from 'lwc';
import generateRecipe from '@salesforce/apex/AIChefController.generateRecipe';

export default class AiChef extends LightningElement {
    @track ingredients = '';
    @track aiRecipeResponse = '';
    @track isLoading = false;

    handleInputChange(event) {
        this.ingredients = event.target.value;
    }

    get isInputEmpty() {
        return !this.ingredients.trim();
    }

    async handleGenerateRecipe() {
        if (this.isInputEmpty) return;

        this.isLoading = true;
        this.aiRecipeResponse = '';

        try {
            // Imperative Apex invocation pass
            const result = await generateRecipe({ ingredients: this.ingredients });
            this.aiRecipeResponse = result;
        } catch (error) {
            console.error('Error invoking Apex Einstein engine: ', error);
            this.aiRecipeResponse = 'An error occurred while communicating with the backend recipe generation model.';
        } finally {
            this.isLoading = false;
        }
    }
}
