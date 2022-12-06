FactoryBot.define do
  factory :recipe do
    title { Faker::Lorem.characters(number: 5) }
    cook_time_mins { Faker::Number.between(from: 0, to: 60) }
    prep_time_mins { Faker::Number.between(from: 0, to: 60) }
    ingredients { Array.new(rand(0...30)) {Faker::Lorem.characters(number: 5)} }
    rating { Faker::Number.between(from: 0, to: 5) }
    image_url { Faker::Avatar.image }
  end
end
