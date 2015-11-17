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

ActiveRecord::Schema.define(version: 20151116160117) do

  create_table "meetings", force: :cascade do |t|
    t.string   "name"
    t.string   "division"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "packs", force: :cascade do |t|
    t.string   "title"
    t.string   "status"
    t.integer  "meeting_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "packs", ["meeting_id"], name: "index_packs_on_meeting_id"

  create_table "updates", force: :cascade do |t|
    t.text     "text"
    t.string   "update_type"
    t.integer  "update_type_id"
    t.date     "date"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "pack_id"
  end

  add_index "updates", ["pack_id"], name: "index_updates_on_pack_id"

end
