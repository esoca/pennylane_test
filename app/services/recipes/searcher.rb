module Recipes
  class Searcher
    attr_reader :ingredient_search_terms, :page_number, :page_size

    # Service that return RecipeSearchResults from a user search:
    # - It's paginated and return a specific Page.
    # - The order of results is first by recipes with fewer ingredients missing and then by the rating.
    #
    # @param [Array<String>] ingredient_search_terms
    # @param [Integer] page_number
    # @param [Integer] page_size
    def initialize(ingredient_search_terms:, page_number:, page_size:)
      raise ArgumentError.new("ingredient_search_terms cannot be empty") if ingredient_search_terms.empty?
      raise ArgumentError.new("page_number should be positive") unless page_number.positive?
      raise ArgumentError.new("page_size should be positive") unless page_size.positive?

      @ingredient_search_terms = ingredient_search_terms
      @page_number = page_number
      @page_size = page_size
    end

    # @return [Page]
    def search
      ingredients_like_sql = ingredient_search_terms.map {|ingredient| '(\m' + Recipe.sanitize_sql_like(ingredient) + '\M)'}
                                                    .join('|')

      sql = <<-SQL
        SELECT
            recipe.*,
            (jsonb_array_length(recipe.ingredients) - COUNT(*)) AS unmatched_ingredients
        FROM recipes recipe, jsonb_array_elements_text(ingredients) AS recipe_ingredient(ingredient)
        WHERE ingredient ~* '#{ingredients_like_sql}'
        GROUP BY (id)
        ORDER BY unmatched_ingredients ASC, rating DESC
      SQL

      recipes_paginated = Recipe.select("*").from("(#{sql}) AS recipe").page(page_number).per(page_size)

      total_count = recipes_paginated.total_count
      recipe_search_results = recipes_paginated.map do |recipe|
        RecipeSearchResult.new(recipe: recipe, unmatched_ingredients: recipe.unmatched_ingredients)
      end

      Page.new(values: recipe_search_results, total_count: total_count, page_number: page_number, page_size: page_size)
    end
  end
end
