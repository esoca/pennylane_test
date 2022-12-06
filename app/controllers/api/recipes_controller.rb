module Api
  class RecipesController < AppController
    def search
      validated_params = Recipes::SearchContract.validate!(params)

      @recipe_search_results_page = ::Recipes::Searcher.new(
        ingredient_search_terms: validated_params[:ingredient_search_terms],
        page_number: validated_params[:page_number].to_i,
        page_size: validated_params[:page_size].to_i,
      ).search
    end
  end
end
