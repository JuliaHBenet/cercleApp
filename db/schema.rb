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

ActiveRecord::Schema.define(version: 20181020132149) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.boolean "lloguer", default: false
    t.string "name"
    t.string "idcard"
    t.string "address"
    t.integer "postcode"
    t.string "city"
    t.string "contactname"
    t.string "contactphone1"
    t.string "contactphone2"
    t.string "contactemail"
    t.text "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true
    t.boolean "falta_info"
  end

  create_table "events", force: :cascade do |t|
    t.string "document"
    t.boolean "representacio"
    t.string "name"
    t.text "description"
    t.datetime "eventstart"
    t.datetime "eventend"
    t.datetime "activitystart"
    t.datetime "activityend"
    t.text "comments"
    t.bigint "client_id"
    t.bigint "room_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "backgroundColor"
    t.string "borderColor"
    t.string "status"
    t.boolean "weekly"
    t.datetime "recurrence_ends_at"
    t.integer "parent_event_id"
    t.boolean "monthly_number"
    t.boolean "monthly_day"
    t.boolean "obert", default: true
    t.string "comments2"
    t.index ["client_id"], name: "index_events_on_client_id"
    t.index ["parent_event_id"], name: "index_events_on_parent_event_id"
    t.index ["room_id"], name: "index_events_on_room_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "events", "clients"
  add_foreign_key "events", "rooms"
  add_foreign_key "events", "users"
end
