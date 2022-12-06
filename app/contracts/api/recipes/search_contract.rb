module Api
  module Recipes
    class SearchContract < AppContract
      params do
        required(:ingredient_search_terms).array(:str?)
        required(:page_number).value(:integer)
        required(:page_size).value(:integer)
      end

      rule(:ingredient_search_terms) do
        count = value.count
        key.failure('size must be between 1 and 30') unless 1 <= count && count <= 30
      end

      rule(:ingredient_search_terms).each do
        length = value.length
        key.failure('term length must be between 1 and 20') unless 1 <= length && length <= 20
      end

      rule(:page_number) do
        key.failure('must be greater than or equal 1') unless value >= 1
      end

      rule(:page_size) do
        key.failure('must be between 1 and 100') unless 1 <= value && value <= 100
      end
    end
  end
end
