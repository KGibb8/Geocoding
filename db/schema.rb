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

ActiveRecord::Schema.define(version: 20161122200147) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "annotations", force: :cascade do |t|
    t.integer  "coordinate_id"
    t.string   "image"
    t.string   "recording"
    t.string   "note"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["coordinate_id"], name: "index_annotations_on_coordinate_id", using: :btree
  end

  create_table "coordinates", force: :cascade do |t|
    t.integer  "expedition_id"
    t.integer  "parent_id"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "accuracy"
    t.float    "bearing"
    t.float    "altitude"
    t.string   "ip"
    t.string   "country_code"
    t.string   "country_name"
    t.string   "region_code"
    t.string   "region_name"
    t.string   "city"
    t.string   "zip_code"
    t.string   "time_zone"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.float    "distance_to_last"
    t.index ["expedition_id"], name: "index_coordinates_on_expedition_id", using: :btree
    t.index ["parent_id"], name: "index_coordinates_on_parent_id", using: :btree
  end

  create_table "expeditions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.integer  "segment",     default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["user_id"], name: "index_expeditions_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
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
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "annotations", "coordinates"
  add_foreign_key "coordinates", "expeditions"
  add_foreign_key "expeditions", "users"
end
