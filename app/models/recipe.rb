class Recipe < ApplicationRecord
  attribute :title, :string
  attribute :cook_time_mins, :integer
  attribute :prep_time_mins, :integer
  attribute :rating, :float
  attribute :ingredients, :jsonb
  attribute :image_url, :string
end
