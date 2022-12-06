class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes, id: :uuid do |t|
      t.string :title, null: false
      t.jsonb :ingredients, null: false
      t.string :image_url, null: false

      t.integer :cook_time_mins, null: false
      t.check_constraint'cook_time_mins >= 0', name: 'cook_time_mins_check'

      t.integer :prep_time_mins, null: false
      t.check_constraint'prep_time_mins >= 0', name: 'prep_time_mins_check'

      t.float :rating, null: false, precision: 3, scale: 2, index: true
      t.check_constraint'rating BETWEEN 0 AND 5', name: 'rating_check'

      t.timestamps default: -> { 'CURRENT_TIMESTAMP' }
    end
  end
end
