# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_02_012913) do

  create_table "hikes", force: :cascade do |t|
    t.datetime "date"
    t.integer "time_hiked"
    t.integer "user_id"
    t.integer "trail_id"
    t.boolean "completed"
  end

  create_table "locations", force: :cascade do |t|
    t.string "town"
    t.string "state"
  end

  create_table "trails", force: :cascade do |t|
    t.string "name"
    t.integer "length"
    t.string "type"
    t.string "summary"
    t.string "difficulty"
    t.integer "rating"
    t.float "longitude"
    t.float "lattitude"
    t.integer "ascent"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password"
  end

end
