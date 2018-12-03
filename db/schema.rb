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

ActiveRecord::Schema.define(version: 2018_12_03_092014) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "choices", force: :cascade do |t|
    t.bigint "potager_id"
    t.bigint "vegetable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["potager_id"], name: "index_choices_on_potager_id"
    t.index ["vegetable_id"], name: "index_choices_on_vegetable_id"
  end

  create_table "parcels", force: :cascade do |t|
    t.bigint "potager_id"
    t.integer "size"
    t.integer "order_from_south"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["potager_id"], name: "index_parcels_on_potager_id"
  end

  create_table "potagers", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "length"
    t.integer "width"
    t.boolean "freezing"
    t.string "orientation"
    t.string "start_month"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: ""
    t.index ["user_id"], name: "index_potagers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vegetables", force: :cascade do |t|
    t.string "name"
    t.string "vegetabletype"
    t.string "month_planted", array: true
    t.integer "distance_between"
    t.integer "luminosity"
    t.integer "humidity"
    t.integer "height"
    t.integer "harvest_time"
    t.string "aromatics", array: true
    t.string "friends", array: true
    t.string "ennemies", array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "frost_resistant"
    t.string "photo"
  end

  create_table "vegetables_parcels", force: :cascade do |t|
    t.bigint "parcel_id"
    t.bigint "vegetable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parcel_id"], name: "index_vegetables_parcels_on_parcel_id"
    t.index ["vegetable_id"], name: "index_vegetables_parcels_on_vegetable_id"
  end

  add_foreign_key "choices", "potagers"
  add_foreign_key "choices", "vegetables"
  add_foreign_key "parcels", "potagers"
  add_foreign_key "potagers", "users"
  add_foreign_key "vegetables_parcels", "parcels"
  add_foreign_key "vegetables_parcels", "vegetables"
end
