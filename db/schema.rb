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

ActiveRecord::Schema.define(version: 20180711174609) do

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
  end

  create_table "events", force: :cascade do |t|
    t.boolean "lloguer"
    t.integer "status"
    t.string "document"
    t.boolean "representacio"
    t.string "name"
    t.text "description"
    t.datetime "eventstart"
    t.datetime "eventend"
    t.datetime "activitystart"
    t.datetime "activityend"
    t.text "comments"
    t.integer "client_id"
    t.integer "room_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_events_on_client_id"
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
  end

end
