require 'rails_helper'

describe Page do
  let(:recipe_search_result) do
    RecipeSearchResult.new(
      recipe: recipe,
      unmatched_ingredients: unmatched_ingredients,
    )
  end
  let(:recipe) { create(:recipe, ingredients: ['Salt', 'Milk', 'Vanilla']) }
  let(:unmatched_ingredients) { 2 }

  describe '#matched_ingredients' do
    it 'should return the difference between all ingredients and the unmatched' do
      expect(recipe_search_result.matched_ingredients).to eq(1)
    end
  end
end
