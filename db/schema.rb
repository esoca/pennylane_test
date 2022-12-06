# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_12_06_203715) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "recipes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title", null: false
    t.jsonb "ingredients", null: false
    t.string "image_url", null: false
    t.integer "cook_time_mins", null: false
    t.integer "prep_time_mins", null: false
    t.float "rating", null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["rating"], name: "index_recipes_on_rating"
    t.check_constraint "cook_time_mins >= 0", name: "cook_time_mins_check"
    t.check_constraint "prep_time_mins >= 0", name: "prep_time_mins_check"
    t.check_constraint "rating >= 0::double precision AND rating <= 5::double precision", name: "rating_check"
  end

end
