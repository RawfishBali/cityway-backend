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

ActiveRecord::Schema.define(version: 20160826042846) do

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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "commonplaces", ["city_id"], name: "index_commonplaces_on_city_id", using: :btree

  create_table "discovers", force: :cascade do |t|
    t.string   "photo"
    t.integer  "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "discovers", ["city_id"], name: "index_discovers_on_city_id", using: :btree

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

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
  end

  add_index "merchants", ["category_id"], name: "index_merchants_on_category_id", using: :btree
  add_index "merchants", ["city_id"], name: "index_merchants_on_city_id", using: :btree

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

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "subcategories", force: :cascade do |t|
    t.string   "name",        null: false
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "subcategories", ["category_id"], name: "index_subcategories_on_category_id", using: :btree

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

  add_foreign_key "identities", "users"
end
