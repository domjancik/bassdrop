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

ActiveRecord::Schema.define(version: 20150327231516) do

  create_table "artists", force: :cascade do |t|
    t.string   "title",               limit: 255
    t.integer  "city_id",             limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "country_id",          limit: 4
    t.string   "link_fb",             limit: 255
    t.datetime "image_url_cached_at"
    t.string   "image_url_cached",    limit: 255
  end

  add_index "artists", ["city_id"], name: "index_artists_on_city_id", using: :btree
  add_index "artists", ["country_id"], name: "index_artists_on_country_id", using: :btree

  create_table "cities", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.integer  "country_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "cities", ["country_id"], name: "index_cities_on_country_id", using: :btree

  create_table "countries", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.string   "abbreviation", limit: 255
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.boolean  "favorite",     limit: 1,   default: false
  end

  add_index "countries", ["abbreviation"], name: "index_countries_on_abbreviation", unique: true, using: :btree
  add_index "countries", ["title"], name: "index_countries_on_title", unique: true, using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "title",            limit: 255
    t.datetime "date_start"
    t.datetime "date_end"
    t.string   "preorder_url",     limit: 255
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "venue_id",         limit: 4
    t.text     "description",      limit: 16777215
    t.string   "link_fb",          limit: 255
    t.datetime "cached_at"
    t.string   "image_url_cached", limit: 255
  end

  add_index "events", ["link_fb"], name: "index_events_on_link_fb", unique: true, using: :btree
  add_index "events", ["venue_id"], name: "index_events_on_venue_id", using: :btree

  create_table "performances", force: :cascade do |t|
    t.integer  "event_id",     limit: 4
    t.integer  "artist_id",    limit: 4
    t.integer  "stage_id",     limit: 4
    t.datetime "date_start"
    t.datetime "date_end"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.boolean  "is_headliner", limit: 1
  end

  add_index "performances", ["artist_id"], name: "index_performances_on_artist_id", using: :btree
  add_index "performances", ["event_id"], name: "index_performances_on_event_id", using: :btree
  add_index "performances", ["stage_id"], name: "index_performances_on_stage_id", using: :btree

  create_table "stages", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.integer  "venue_id",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "stages", ["venue_id"], name: "index_stages_on_venue_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: ""
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                   limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.integer  "role",                   limit: 4
    t.string   "invitation_token",       limit: 255
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit",       limit: 4
    t.integer  "invited_by_id",          limit: 4
    t.string   "invited_by_type",        limit: 255
    t.integer  "invitations_count",      limit: 4,   default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "venues", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "address",    limit: 255
    t.string   "url",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_foreign_key "artists", "cities"
  add_foreign_key "artists", "countries"
  add_foreign_key "cities", "countries"
  add_foreign_key "events", "venues"
  add_foreign_key "performances", "artists"
  add_foreign_key "performances", "events"
  add_foreign_key "performances", "stages"
  add_foreign_key "stages", "venues"
end
