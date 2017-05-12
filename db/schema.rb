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

ActiveRecord::Schema.define(version: 20170512181539) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "name"
    t.string   "registered_at"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.string   "phone"
    t.float    "account_credit"
    t.integer  "movies_checked_out_count"
  end

  create_table "movies", force: :cascade do |t|
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "title"
    t.string   "overview"
    t.string   "release_date"
    t.integer  "inventory"
    t.integer  "available_inventory"
  end

  create_table "rentals", force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "customers_id"
    t.integer  "movies_id"
    t.string   "checkout_date"
    t.string   "due_date"
    t.index ["customers_id"], name: "index_rentals_on_customers_id", using: :btree
    t.index ["movies_id"], name: "index_rentals_on_movies_id", using: :btree
  end

  add_foreign_key "rentals", "customers", column: "customers_id"
  add_foreign_key "rentals", "movies", column: "movies_id"
end
