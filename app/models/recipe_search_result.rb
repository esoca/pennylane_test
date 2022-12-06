class RecipeSearchResult
  attr_reader :recipe, :unmatched_ingredients

  def initialize(recipe:, unmatched_ingredients:)
    @recipe = recipe
    @unmatched_ingredients = unmatched_ingredients
  end

  def matched_ingredients
    recipe.ingredients.count - unmatched_ingredients
  end
end
