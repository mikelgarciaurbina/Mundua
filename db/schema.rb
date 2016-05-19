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

ActiveRecord::Schema.define(version: 20160517102444) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "groups", force: :cascade do |t|
    t.integer  "house_id"
    t.string   "name"
    t.text     "description"
    t.string   "friends_requests"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "owner_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "groups", ["house_id"], name: "index_groups_on_house_id", using: :btree

  create_table "hobbies", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "houses", force: :cascade do |t|
    t.decimal  "latitude",           precision: 20, scale: 12
    t.decimal  "longitude",          precision: 20, scale: 12
    t.string   "address"
    t.integer  "rooms"
    t.text     "description"
    t.string   "groups_requests"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.integer  "owner_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "technologies", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_hobbies", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "hobby_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_hobbies", ["hobby_id"], name: "index_user_hobbies_on_hobby_id", using: :btree
  add_index "user_hobbies", ["user_id"], name: "index_user_hobbies_on_user_id", using: :btree

  create_table "user_technologies", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "technology_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "user_technologies", ["technology_id"], name: "index_user_technologies_on_technology_id", using: :btree
  add_index "user_technologies", ["user_id"], name: "index_user_technologies_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.integer  "group_id"
    t.string   "name"
    t.string   "lastname"
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

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["group_id"], name: "index_users_on_group_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
