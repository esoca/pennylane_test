module Recipes
  class Seeder
    def seed
      return 0 if already_seeded?

      scraped_recipes_json = File.read("#{Rails.root}/db/recipes-en.json")
      scraped_recipes = JSON.parse(scraped_recipes_json)

      recipes = scraped_recipes.map do |scraped_recipe|
        Recipe.new(
          title: scraped_recipe['title'],
          cook_time_mins: scraped_recipe['cook_time'],
          prep_time_mins: scraped_recipe['prep_time'],
          ingredients: scraped_recipe['ingredients'],
          rating: scraped_recipe['ratings'],
          image_url: scraped_recipe['image'],
        )
      end

      Recipe.import(recipes)

      recipes.count
    end

    private

    def already_seeded?
      Recipe.count != 0
    end
  end
end
