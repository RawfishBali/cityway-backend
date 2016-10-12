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

ActiveRecord::Schema.define(version: 20161012071235) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_tokens", force: :cascade do |t|
    t.string   "token"
    t.datetime "expired_at"
    t.integer  "client_application_id"
    t.integer  "user_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "refresh_token"
  end

  add_index "access_tokens", ["client_application_id"], name: "index_access_tokens_on_client_application_id", using: :btree
  add_index "access_tokens", ["user_id"], name: "index_access_tokens_on_user_id", using: :btree

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "admins_roles", id: false, force: :cascade do |t|
    t.integer "admin_id"
    t.integer "role_id"
  end

  add_index "admins_roles", ["admin_id", "role_id"], name: "index_admins_roles_on_admin_id_and_role_id", using: :btree

  create_table "advertisements", force: :cascade do |t|
    t.string   "photo"
    t.boolean  "active",            default: false
    t.integer  "position"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.datetime "second_start_date"
    t.datetime "second_end_date"
  end

  create_table "advertisements_cities", force: :cascade do |t|
    t.integer "city_id",          null: false
    t.integer "advertisement_id", null: false
  end

  add_index "advertisements_cities", ["advertisement_id"], name: "index_advertisements_cities_on_advertisement_id", using: :btree
  add_index "advertisements_cities", ["city_id"], name: "index_advertisements_cities_on_city_id", using: :btree

  create_table "arounds", force: :cascade do |t|
    t.string   "photo"
    t.integer  "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "arounds", ["city_id"], name: "index_arounds_on_city_id", using: :btree

  create_table "business_hours", force: :cascade do |t|
    t.integer  "day",                                null: false
    t.time     "morning_open_time",                  null: false
    t.time     "morning_close_time",                 null: false
    t.time     "evening_open_time"
    t.time     "evening_close_time"
    t.boolean  "open_all_day",       default: false
    t.integer  "marketable_id"
    t.string   "marketable_type"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.boolean  "is_open_today",      default: false
  end

  add_index "business_hours", ["marketable_type", "marketable_id"], name: "index_business_hours_on_marketable_type_and_marketable_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "photo"
    t.string   "icon"
  end

  add_index "categories", ["parent_id"], name: "index_categories_on_parent_id", using: :btree

  create_table "categories_cities", force: :cascade do |t|
    t.integer  "city_id",     null: false
    t.integer  "category_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "categories_cities", ["category_id"], name: "index_categories_cities_on_category_id", using: :btree
  add_index "categories_cities", ["city_id"], name: "index_categories_cities_on_city_id", using: :btree

  create_table "categories_merchants", force: :cascade do |t|
    t.integer "merchant_id", null: false
    t.integer "category_id", null: false
  end

  add_index "categories_merchants", ["category_id"], name: "index_categories_merchants_on_category_id", using: :btree
  add_index "categories_merchants", ["merchant_id"], name: "index_categories_merchants_on_merchant_id", using: :btree

  create_table "ceritificates", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "commonplace_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "certificates", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "commonplace_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name",        null: false
    t.float    "latitude",    null: false
    t.float    "longitude",   null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "description"
    t.string   "photo"
  end

  add_index "cities", ["latitude", "longitude"], name: "index_cities_on_latitude_and_longitude", using: :btree

  create_table "city_hall_stories", force: :cascade do |t|
    t.text     "top_text",       null: false
    t.text     "bottom_text",    null: false
    t.integer  "commonplace_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "client_applications", force: :cascade do |t|
    t.string   "name"
    t.string   "key"
    t.string   "secret"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "commonplaces", force: :cascade do |t|
    t.string   "photo"
    t.string   "icon"
    t.integer  "city_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "history"
    t.string   "facebook"
    t.string   "instagram"
    t.string   "twitter"
    t.string   "google_plus"
  end

  add_index "commonplaces", ["city_id"], name: "index_commonplaces_on_city_id", using: :btree

  create_table "coordinates", force: :cascade do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "ztl_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "culinaries", force: :cascade do |t|
    t.string   "name",          null: false
    t.text     "description"
    t.integer  "discover_id"
    t.integer  "culinary_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "devices", force: :cascade do |t|
    t.integer  "device_type"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address"
    t.string   "external_url"
    t.integer  "utility_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "name"
  end

  create_table "discovers", force: :cascade do |t|
    t.string   "photo"
    t.integer  "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "discovers", ["city_id"], name: "index_discovers_on_city_id", using: :btree

  create_table "event_dates", force: :cascade do |t|
    t.date     "event_date"
    t.string   "day_name"
    t.time     "open_time"
    t.time     "close_time"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "event_dates", ["event_id"], name: "index_event_dates_on_event_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "title",                                null: false
    t.string   "photo",                                null: false
    t.string   "address",                              null: false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "website"
    t.string   "email"
    t.string   "facebook"
    t.string   "instagram"
    t.boolean  "support_disabilities", default: false
    t.text     "description"
    t.integer  "around_id",                            null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "events", ["around_id"], name: "index_events_on_around_id", using: :btree

  create_table "garbage_glossaries", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description", null: false
    t.integer  "utility_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "itineraries", force: :cascade do |t|
    t.string   "name",          null: false
    t.text     "description"
    t.integer  "discover_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "visiting_time"
  end

  create_table "large_garbages", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "address",     null: false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "phone"
    t.string   "website"
    t.string   "email"
    t.text     "description"
    t.integer  "utility_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "markets", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "address",     null: false
    t.float    "latitude"
    t.float    "longitude"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "around_id"
  end

  add_index "markets", ["around_id"], name: "index_markets_on_around_id", using: :btree

  create_table "merchants", force: :cascade do |t|
    t.string   "name",                                 null: false
    t.string   "address",                              null: false
    t.string   "phone"
    t.string   "email"
    t.string   "website"
    t.string   "facebook"
    t.string   "instagram"
    t.text     "description"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "support_disabilities", default: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "city_id"
    t.integer  "category_id"
    t.string   "photo"
    t.string   "icon"
    t.string   "twitter"
    t.string   "google_plus"
  end

  add_index "merchants", ["category_id"], name: "index_merchants_on_category_id", using: :btree
  add_index "merchants", ["city_id"], name: "index_merchants_on_city_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.integer  "message_type",   null: false
    t.text     "message",        null: false
    t.integer  "commonplace_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "messages", ["commonplace_id"], name: "index_messages_on_commonplace_id", using: :btree

  create_table "news", force: :cascade do |t|
    t.string   "title",          null: false
    t.string   "photo"
    t.datetime "published_at",   null: false
    t.text     "description",    null: false
    t.integer  "commonplace_id", null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "url"
  end

  add_index "news", ["commonplace_id"], name: "index_news_on_commonplace_id", using: :btree

  create_table "online_services", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "commonplace_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "parking_areas", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "total_parking_lot"
    t.integer  "available_parking_lot"
    t.integer  "utility_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "parks", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "support_disabilities"
    t.text     "description"
    t.integer  "around_id",            null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "parks", ["around_id"], name: "index_parks_on_around_id", using: :btree

  create_table "paths", force: :cascade do |t|
    t.text     "path",                null: false
    t.integer  "public_transport_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "photos", force: :cascade do |t|
    t.string   "picture"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.boolean  "is_primary",     default: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "position"
  end

  add_index "photos", ["imageable_type", "imageable_id"], name: "index_photos_on_imageable_type_and_imageable_id", using: :btree

  create_table "places", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "email"
    t.string   "website"
    t.string   "facebook"
    t.string   "instagram"
    t.string   "twitter"
    t.string   "google_plus"
    t.integer  "discover_id"
    t.integer  "place_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "politic_groups", force: :cascade do |t|
    t.string   "name",           null: false
    t.integer  "commonplace_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "politic_groups", ["commonplace_id"], name: "index_politic_groups_on_commonplace_id", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.string   "name",                                   null: false
    t.string   "role"
    t.string   "phone"
    t.string   "fax"
    t.integer  "days_open",                                           array: true
    t.time     "appointment_start"
    t.time     "appointment_end"
    t.string   "photo"
    t.boolean  "is_major",               default: false
    t.boolean  "is_city_council_member", default: false
    t.integer  "politic_group_id"
    t.integer  "commonplace_id"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "website"
    t.text     "description"
    t.string   "email"
    t.string   "city_hall_name"
  end

  add_index "profiles", ["commonplace_id"], name: "index_profiles_on_commonplace_id", using: :btree
  add_index "profiles", ["politic_group_id"], name: "index_profiles_on_politic_group_id", using: :btree

  create_table "promos", force: :cascade do |t|
    t.text     "title"
    t.string   "photo"
    t.text     "description"
    t.text     "terms_and_conditions"
    t.float    "discount"
    t.float    "original_price"
    t.float    "discount_price"
    t.integer  "merchant_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "city_id"
    t.boolean  "approval",             default: false
  end

  add_index "promos", ["city_id"], name: "index_promos_on_city_id", using: :btree
  add_index "promos", ["merchant_id"], name: "index_promos_on_merchant_id", using: :btree

  create_table "public_offices", force: :cascade do |t|
    t.string   "name",           null: false
    t.string   "photo"
    t.text     "description"
    t.string   "email"
    t.string   "address"
    t.string   "phone"
    t.string   "fax"
    t.integer  "commonplace_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "website"
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "public_offices", ["commonplace_id"], name: "index_public_offices_on_commonplace_id", using: :btree

  create_table "public_transports", force: :cascade do |t|
    t.string   "name"
    t.string   "attachment"
    t.integer  "transport_type"
    t.integer  "utility_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "securities", force: :cascade do |t|
    t.string   "name",           null: false
    t.string   "url",            null: false
    t.integer  "commonplace_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "securities", ["commonplace_id"], name: "index_securities_on_commonplace_id", using: :btree

  create_table "steps", force: :cascade do |t|
    t.string   "address",      null: false
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "itinerary_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "name"
    t.text     "description"
    t.integer  "position"
  end

  create_table "stories", force: :cascade do |t|
    t.text     "top_text"
    t.text     "bottom_text"
    t.integer  "discover_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "external_link"
  end

  create_table "subcategories", force: :cascade do |t|
    t.string   "name",        null: false
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "subcategories", ["category_id"], name: "index_subcategories_on_category_id", using: :btree

  create_table "taxis", force: :cascade do |t|
    t.string   "contact_name"
    t.string   "phone_number"
    t.string   "website"
    t.integer  "utility_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "firstname"
    t.string   "lastname"
    t.boolean  "newsletter",             default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "utilities", force: :cascade do |t|
    t.string   "photo"
    t.integer  "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "utilities", ["city_id"], name: "index_utilities_on_city_id", using: :btree

  create_table "utility_numbers", force: :cascade do |t|
    t.string   "name"
    t.string   "local_number"
    t.string   "national_number"
    t.string   "address"
    t.integer  "utility_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "utility_places", force: :cascade do |t|
    t.string   "name"
    t.string   "denomination"
    t.text     "description"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "email"
    t.string   "phone"
    t.integer  "place_type"
    t.integer  "visitable_id"
    t.string   "visitable_type"
    t.boolean  "is_public",      default: true
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "website"
    t.boolean  "commercial"
  end

  add_index "utility_places", ["visitable_type", "visitable_id"], name: "index_utility_places_on_visitable_type_and_visitable_id", using: :btree

  create_table "vehicles", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "phone_0"
    t.string   "phone_1"
    t.string   "website"
    t.string   "email"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "available_parking_lot"
    t.integer  "total_parking_lot"
    t.integer  "vehicle_type"
    t.integer  "utility_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "waste_managements", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "website"
    t.text     "note"
    t.boolean  "delivered_together", default: false
    t.integer  "utility_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "wizards", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ztls", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "utility_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_foreign_key "identities", "users"
end
