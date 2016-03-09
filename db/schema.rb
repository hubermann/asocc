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

ActiveRecord::Schema.define(version: 20160309010908) do

  create_table "profiles", force: :cascade do |t|
    t.string   "bio"
    t.string   "telephone"
    t.string   "avatar_url"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "bio"
    t.string   "name"
    t.string   "lastname"
    t.string   "company"
    t.string   "avatar_url"
    t.string   "background_url"
    t.string   "css_bg_color"
    t.string   "css_links_color"
    t.string   "css_primary_color"
    t.string   "css_secondary_color"
    t.string   "website"
    t.string   "country"
    t.string   "city"
    t.string   "address"
    t.string   "public_email"
    t.string   "public_phone"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "lastname"
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "salt"
    t.string   "persistence_token",               null: false
    t.string   "single_access_token",             null: false
    t.string   "perishable_token",                null: false
    t.integer  "login_count",         default: 0, null: false
    t.integer  "failed_login_count",  default: 0, null: false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

end
