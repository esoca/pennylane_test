require 'rails_helper'

describe Page do
  let(:page) do
    Page.new(
      values: recipe_search_results,
      total_count: total_count,
      page_number: page_number,
      page_size: page_size,
    )
  end
  let(:page_number) { 1 }
  let(:page_size) { 5 }
  let(:recipes) { create_list(:recipe, page_size) }
  let(:recipe_search_results) { recipes.map { |recipe| RecipeSearchResult.new(recipe: recipe, unmatched_ingredients: 2) } }

  describe '#total_pages' do
    context 'when total_count/page_size is exact' do
      let(:total_count) { 10 }
      let(:page_size) { 5 }

      it 'should return the exact quotient' do
        expect(page.total_pages).to eq(2)
      end
    end

    context 'when total_count/page_size is not exact' do
      let(:total_count) { 10 }
      let(:page_size) { 4 }

      it 'should return quotient plus 1' do
        expect(page.total_pages).to eq(3)
      end
    end
  end
end
