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

ActiveRecord::Schema[7.0].define(version: 2023_08_31_092349) do
  create_table "bookings", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "football_pitch_id"
    t.decimal "booking_price", precision: 10
    t.bigint "discount_id"
    t.decimal "used_discount_value", precision: 10
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer "status"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discount_id"], name: "index_bookings_on_discount_id", unique: true
    t.index ["football_pitch_id"], name: "index_bookings_on_football_pitch_id", unique: true
    t.index ["user_id"], name: "index_bookings_on_user_id", unique: true
  end

  create_table "discounts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.integer "type"
    t.decimal "value", precision: 10
    t.integer "usage_count"
    t.integer "total_usage"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorite_pitches", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "football_pitch_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["football_pitch_id"], name: "index_favorite_pitches_on_football_pitch_id", unique: true
    t.index ["user_id"], name: "index_favorite_pitches_on_user_id", unique: true
  end

  create_table "football_pitches", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.float "length"
    t.float "width"
    t.integer "capacity"
    t.decimal "price", precision: 10
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "football_pitch_id"
    t.text "comment"
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["football_pitch_id"], name: "index_reviews_on_football_pitch_id", unique: true
    t.index ["user_id"], name: "index_reviews_on_user_id", unique: true
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "password"
    t.string "phone"
    t.boolean "is_admin"
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "is_activated", default: false
    t.string "activation_digest"
    t.datetime "activation_at"
    t.string "reset_digest"
    t.string "reset_digest_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
