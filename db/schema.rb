# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150126145602) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "flags", force: true do |t|
    t.integer  "user_id"
    t.integer  "market_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "flags", ["market_id"], name: "index_flags_on_market_id", using: :btree
  add_index "flags", ["user_id"], name: "index_flags_on_user_id", using: :btree

  create_table "listings", force: true do |t|
    t.string   "name",                              null: false
    t.string   "description"
    t.date     "harvest_date",                      null: false
    t.boolean  "active",             default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "market_id",                         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "listings", ["market_id"], name: "index_listings_on_market_id", using: :btree

  create_table "markets", force: true do |t|
    t.string   "name",               null: false
    t.string   "google_link"
    t.string   "full_address"
    t.string   "schedule"
    t.string   "products"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "zip",                null: false
    t.string   "slug"
    t.string   "street",             null: false
    t.string   "city",               null: false
    t.string   "state",              null: false
    t.integer  "user_id",            null: false
    t.string   "email"
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "markets", ["user_id"], name: "index_markets_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "provider",    null: false
    t.string   "uid",         null: false
    t.string   "name",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.string   "description"
    t.string   "location"
  end

end
