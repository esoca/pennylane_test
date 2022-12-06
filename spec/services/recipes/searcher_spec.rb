require 'rails_helper'

describe Recipes::Searcher do
  let(:searcher) do
    Recipes::Searcher.new(
      ingredient_search_terms: ingredient_search_terms,
      page_number: page_number,
      page_size: page_size,
    )
  end
  let(:ingredient_search_terms) { ['Milk', 'Yogurt'] }
  let(:page_number) { 1 }
  let(:page_size) { 4 }
  let!(:recipe_0) { create(:recipe, ingredients: ['Milk', 'Yogurt'], rating: 5) }
  let!(:recipe_1) { create(:recipe, ingredients: ['Milk', 'Yogurt'], rating: 4) }
  let!(:recipe_2) { create(:recipe, ingredients: ['Milk', 'Sugar'], rating: 4) }
  let!(:recipe_3) { create(:recipe, ingredients: ['Milk', 'Sugar'], rating: 3) }
  let!(:recipe_4) { create(:recipe, ingredients: ['Milk', 'Sugar'], rating: 2) }
  let!(:recipe_5) { create(:recipe, ingredients: ['Chocolate'], rating: 4) }
  let!(:recipe_6) { create(:recipe, ingredients: ['Chocolate'], rating: 3) }

  describe '#search' do
    it 'returns a Page instance with 4 recipes order by unmatched_ingredients and ranking' do
      page = searcher.search

      expect(page.total_count).to eq(5)
      expect(page.page_number).to eq(1)
      expect(page.page_size).to eq(4)
      expect(page.total_pages).to eq(2)

      recipe_search_result_0 = page.values[0]
      expect(recipe_search_result_0.recipe).to eq(recipe_0)
      expect(recipe_search_result_0.unmatched_ingredients).to eq(0)
      expect(recipe_search_result_0.matched_ingredients).to eq(2)

      recipe_search_result_1 = page.values[1]
      expect(recipe_search_result_1.recipe).to eq(recipe_1)
      expect(recipe_search_result_1.unmatched_ingredients).to eq(0)
      expect(recipe_search_result_1.matched_ingredients).to eq(2)

      recipe_search_result_2 = page.values[2]
      expect(recipe_search_result_2.recipe).to eq(recipe_2)
      expect(recipe_search_result_2.unmatched_ingredients).to eq(1)
      expect(recipe_search_result_2.matched_ingredients).to eq(1)

      recipe_search_result_3 = page.values[3]
      expect(recipe_search_result_3.recipe).to eq(recipe_3)
      expect(recipe_search_result_3.unmatched_ingredients).to eq(1)
      expect(recipe_search_result_3.matched_ingredients).to eq(1)
    end

    context 'when 2nd page' do
      let(:page_number) { 2 }

      it 'returns a Page instance with 1 recipe' do
        page = searcher.search

        expect(page.total_count).to eq(5)
        expect(page.page_number).to eq(2)
        expect(page.page_size).to eq(4)
        expect(page.total_pages).to eq(2)

        recipe_search_result_0 = page.values[0]
        expect(recipe_search_result_0.recipe).to eq(recipe_4)
        expect(recipe_search_result_0.unmatched_ingredients).to eq(1)
        expect(recipe_search_result_0.matched_ingredients).to eq(1)
      end
    end

    context 'when 3nd page' do
      let(:page_number) { 3 }

      it 'returns a Page instance with zero recipes' do
        page = searcher.search

        expect(page.total_count).to eq(5)
        expect(page.page_number).to eq(3)
        expect(page.page_size).to eq(4)
        expect(page.total_pages).to eq(2)

        expect(page.values.count).to eq(0)
      end
    end

    context 'when ingredient_search_terms is empty' do
      let(:ingredient_search_terms) { [] }

      it 'should raises ArgumentError' do
        expect { searcher.search }.to raise_error(ArgumentError)
      end
    end

    context 'when page_number is zero' do
      let(:page_number) { 0 }

      it 'should raises ArgumentError' do
        expect { searcher.search }.to raise_error(ArgumentError)
      end
    end

    context 'when page_number is negative' do
      let(:page_number) { -2 }

      it 'should raises ArgumentError' do
        expect { searcher.search }.to raise_error(ArgumentError)
      end
    end

    context 'when page_size is zero' do
      let(:page_size) { 0 }

      it 'should raises ArgumentError' do
        expect { searcher.search }.to raise_error(ArgumentError)
      end
    end

    context 'when page_size is negative' do
      let(:page_size) { -2 }

      it 'should raises ArgumentError' do
        expect { searcher.search }.to raise_error(ArgumentError)
      end
    end
  end
end
