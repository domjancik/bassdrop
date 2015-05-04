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

ActiveRecord::Schema.define(version: 20150504100521) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: :cascade do |t|
    t.string   "title"
    t.integer  "city_id"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.integer  "country_id"
    t.string   "link_fb"
    t.datetime "image_url_cached_at"
    t.string   "image_url_cached"
    t.integer  "role",                limit: 8, default: 0
    t.integer  "playlist_id"
    t.string   "link_twitter"
    t.string   "link_youtube"
    t.string   "link_instagram"
    t.text     "description"
    t.string   "link_soundcloud"
    t.string   "team_title"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "released_record",               default: false, null: false
    t.text     "description_cs"
    t.string   "id_string",                                     null: false
    t.boolean  "featured",                      default: false, null: false
  end

  add_index "artists", ["city_id"], name: "index_artists_on_city_id", using: :btree
  add_index "artists", ["country_id"], name: "index_artists_on_country_id", using: :btree
  add_index "artists", ["id_string"], name: "index_artists_on_id_string", unique: true, using: :btree
  add_index "artists", ["link_fb"], name: "index_artists_on_link_fb", unique: true, using: :btree
  add_index "artists", ["playlist_id"], name: "index_artists_on_playlist_id", using: :btree
  add_index "artists", ["title"], name: "index_artists_on_title", unique: true, using: :btree

  create_table "cities", force: :cascade do |t|
    t.string   "title"
    t.integer  "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "cities", ["country_id"], name: "index_cities_on_country_id", using: :btree
  add_index "cities", ["title", "country_id"], name: "index_cities_on_title_and_country_id", unique: true, using: :btree

  create_table "countries", force: :cascade do |t|
    t.string   "title"
    t.string   "abbreviation"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "favorite",     default: false
  end

  add_index "countries", ["abbreviation"], name: "index_countries_on_abbreviation", unique: true, using: :btree
  add_index "countries", ["title"], name: "index_countries_on_title", unique: true, using: :btree

  create_table "credits", force: :cascade do |t|
    t.string   "title"
    t.integer  "release_id"
    t.integer  "artist_id"
    t.integer  "list_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "credits", ["artist_id"], name: "index_credits_on_artist_id", using: :btree
  add_index "credits", ["release_id"], name: "index_credits_on_release_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.datetime "date_start"
    t.datetime "date_end"
    t.string   "preorder_url"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "venue_id"
    t.text     "description"
    t.string   "link_fb"
    t.datetime "cached_at"
    t.string   "image_url_cached"
    t.integer  "attending_count"
    t.datetime "stats_updated_at"
    t.integer  "playlist_id"
    t.boolean  "published",          default: false, null: false
    t.boolean  "automatic_updates",  default: true,  null: false
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.boolean  "markdown_enabled",   default: false, null: false
    t.text     "description_cs"
    t.string   "id_string",                          null: false
  end

  add_index "events", ["id_string"], name: "index_events_on_id_string", unique: true, using: :btree
  add_index "events", ["link_fb"], name: "index_events_on_link_fb", unique: true, using: :btree
  add_index "events", ["playlist_id"], name: "index_events_on_playlist_id", using: :btree
  add_index "events", ["venue_id"], name: "index_events_on_venue_id", using: :btree

  create_table "images", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "images", ["title"], name: "index_images_on_title", unique: true, using: :btree

  create_table "media", force: :cascade do |t|
    t.string   "title"
    t.string   "url",         null: false
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "release_id"
  end

  add_index "media", ["release_id"], name: "index_media_on_release_id", using: :btree
  add_index "media", ["url"], name: "index_media_on_url", unique: true, using: :btree

  create_table "performances", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "artist_id"
    t.integer  "stage_id"
    t.datetime "date_start"
    t.datetime "date_end"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.boolean  "is_headliner"
    t.integer  "b2b_id"
  end

  add_index "performances", ["artist_id"], name: "index_performances_on_artist_id", using: :btree
  add_index "performances", ["b2b_id"], name: "index_performances_on_b2b_id", using: :btree
  add_index "performances", ["event_id"], name: "index_performances_on_event_id", using: :btree
  add_index "performances", ["stage_id"], name: "index_performances_on_stage_id", using: :btree

  create_table "playlist_items", force: :cascade do |t|
    t.integer  "playlist_id"
    t.integer  "list_order"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "medium_id"
  end

  add_index "playlist_items", ["medium_id"], name: "index_playlist_items_on_medium_id", using: :btree
  add_index "playlist_items", ["playlist_id"], name: "index_playlist_items_on_playlist_id", using: :btree

  create_table "playlists", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "releases", force: :cascade do |t|
    t.string   "title"
    t.string   "rel_code",                                  null: false
    t.string   "get_url"
    t.string   "get_text"
    t.date     "release_date"
    t.integer  "release_type",        limit: 8, default: 0, null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.text     "description"
    t.integer  "playlist_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.text     "description_cs"
    t.string   "id_string",                                 null: false
  end

  add_index "releases", ["id_string"], name: "index_releases_on_id_string", unique: true, using: :btree
  add_index "releases", ["playlist_id"], name: "index_releases_on_playlist_id", using: :btree
  add_index "releases", ["rel_code"], name: "index_releases_on_rel_code", unique: true, using: :btree

  create_table "stages", force: :cascade do |t|
    t.string   "title"
    t.integer  "venue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "stages", ["venue_id"], name: "index_stages_on_venue_id", using: :btree

  create_table "stories", force: :cascade do |t|
    t.string   "title",                               null: false
    t.text     "description"
    t.integer  "release_id"
    t.integer  "artist_id"
    t.integer  "event_id"
    t.integer  "playlist_id"
    t.integer  "author_id",                           null: false
    t.datetime "published_at"
    t.boolean  "published",           default: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.text     "description_cs"
    t.string   "title_cs"
  end

  add_index "stories", ["artist_id"], name: "index_stories_on_artist_id", using: :btree
  add_index "stories", ["author_id"], name: "index_stories_on_author_id", using: :btree
  add_index "stories", ["event_id"], name: "index_stories_on_event_id", using: :btree
  add_index "stories", ["playlist_id"], name: "index_stories_on_playlist_id", using: :btree
  add_index "stories", ["release_id"], name: "index_stories_on_release_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "role"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
    t.integer  "artist_id"
  end

  add_index "users", ["artist_id"], name: "index_users_on_artist_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "venues", force: :cascade do |t|
    t.string   "title"
    t.string   "address"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "link_fb"
  end

  add_index "venues", ["link_fb"], name: "index_venues_on_link_fb", unique: true, using: :btree

  add_foreign_key "artists", "cities"
  add_foreign_key "artists", "countries"
  add_foreign_key "artists", "playlists"
  add_foreign_key "cities", "countries"
  add_foreign_key "credits", "artists"
  add_foreign_key "credits", "releases"
  add_foreign_key "events", "playlists"
  add_foreign_key "events", "venues"
  add_foreign_key "media", "releases"
  add_foreign_key "performances", "artists"
  add_foreign_key "performances", "events"
  add_foreign_key "performances", "performances", column: "b2b_id", on_delete: :nullify
  add_foreign_key "performances", "stages"
  add_foreign_key "playlist_items", "media"
  add_foreign_key "playlist_items", "playlists"
  add_foreign_key "releases", "playlists"
  add_foreign_key "stages", "venues"
  add_foreign_key "stories", "artists"
  add_foreign_key "stories", "artists"
  add_foreign_key "stories", "events"
  add_foreign_key "stories", "playlists"
  add_foreign_key "stories", "releases"
  add_foreign_key "users", "artists"
end
