require 'rails_helper'

describe Recipes::Seeder do
  let(:seeder) { Recipes::Seeder.new }
  let(:scraped_recipes_json) do
    [
      {
        "title": "Golden Sweet Cornbread",
        "cook_time": 25,
        "prep_time": 10,
        "ingredients": [
          "1 cup all-purpose flour",
          "1 cup yellow cornmeal",
          "⅔ cup white sugar",
          "1 teaspoon salt",
          "3 ½ teaspoons baking powder",
          "1 egg","1 cup milk",
          "⅓ cup vegetable oil"
        ],
        "ratings": 4.74,
        "cuisine": "",
        "category": "Cornbread",
        "author": "bluegirl",
        "image": "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F43%2F2021%2F10%2F26%2Fcornbread-1.jpg"
      },
      {
        "title": "Monkey Bread I",
        "cook_time": 35,
        "prep_time": 15,
        "ingredients": [
          "3 (12 ounce) packages refrigerated biscuit dough",
          "1 cup white sugar",
          "2 teaspoons ground cinnamon",
          "½ cup margarine",
          "1 cup packed brown sugar",
          "½ cup chopped walnuts",
          "½ cup raisins"
        ],
        "ratings": 4.74,
        "cuisine": "",
        "category": "Monkey Bread",
        "author": "deleteduser",
        "image": "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F43%2F2018%2F11%2F546316.jpg"
      },
      {
        "title": "Whole Wheat Beer Bread",
        "cook_time": 50,
        "prep_time": 10,
        "ingredients": [
          "1 ½ cups all-purpose flour",
          "1 ½ cups whole wheat flour",
          "4 ½ teaspoons baking powder",
          "1 ½ teaspoons salt",
          "⅓ cup packed brown sugar",
          "1 (12 fluid ounce) can or bottle beer"
        ],
        "ratings": 4.52,
        "cuisine": "",
        "category": "Quick Bread",
        "author": "Betty Latvala",
        "image": "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F9443508.jpg"
      },
    ].to_json
  end

  before do
    allow(File).to receive(:read).and_return(scraped_recipes_json)
  end

  describe '#seed' do
    it 'persists all the available recipes into the db and return the new persisted number' do
      new_recipes_count = seeder.seed

      expect(new_recipes_count).to eq(3)
      expect(Recipe.count).to eq(3)
    end

    context 'when the system already contains persisted recipes' do
      let!(:recipe) { create(:recipe) }

      it 'does not persist any new recipe and return 0' do
        new_recipes_count = seeder.seed

        expect(new_recipes_count).to eq(0)
        expect(Recipe.count).to eq(1)
      end
    end
  end
end