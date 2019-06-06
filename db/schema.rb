# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_06_06_184512) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_cocktail_infos", force: :cascade do |t|
    t.integer "api_cocktail_id"
    t.string "name"
    t.string "imageUrl"
    t.text "instructions"
    t.string "category"
    t.string "alcoholic"
    t.string "glass"
    t.string "videoUrl"
    t.string "ingredient_1"
    t.string "ingredient_2"
    t.string "ingredient_3"
    t.string "ingredient_4"
    t.string "ingredient_5"
    t.string "ingredient_6"
    t.string "ingredient_7"
    t.string "ingredient_8"
    t.string "ingredient_9"
    t.string "ingredient_10"
    t.string "ingredient_11"
    t.string "ingredient_12"
    t.string "ingredient_13"
    t.string "ingredient_14"
    t.string "ingredient_15"
    t.string "measurement_1"
    t.string "measurement_2"
    t.string "measurement_3"
    t.string "measurement_4"
    t.string "measurement_5"
    t.string "measurement_6"
    t.string "measurement_7"
    t.string "measurement_8"
    t.string "measurement_9"
    t.string "measurement_10"
    t.string "measurement_11"
    t.string "measurement_12"
    t.string "measurement_13"
    t.string "measurement_14"
    t.string "measurement_15"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cocktail_ingredients", force: :cascade do |t|
    t.integer "cocktail_id"
    t.integer "api_cocktail_id"
    t.integer "ingredient_id"
    t.integer "api_ingredient_id"
    t.string "measurement"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cocktails", force: :cascade do |t|
    t.integer "api_drink_id"
    t.string "name"
    t.text "instructions"
    t.string "category"
    t.string "alcoholic"
    t.string "glass"
    t.string "videoURL"
    t.string "imageUrl"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "review_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["review_id"], name: "index_comments_on_review_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.integer "api_ingredient_id"
    t.string "name"
    t.string "category"
    t.text "description"
    t.string "imageUrl"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "drink_id"
    t.integer "api_drink_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "drink_id"
    t.integer "api_drink_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.text "bio"
    t.date "birthdate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "img_url"
  end

end
