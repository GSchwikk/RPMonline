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

ActiveRecord::Schema.define(version: 20160125115630) do

  create_table "Steps", force: :cascade do |t|
    t.text     "description"
    t.date     "due_date"
    t.string   "status"
    t.integer  "user_id"
    t.integer  "pack_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "Steps", ["pack_id"], name: "index_actions_on_pack_id"
  add_index "Steps", ["user_id"], name: "index_actions_on_user_id"

  create_table "divisions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "user_id"
    t.integer  "organisation_id"
  end

  create_table "kpi_datapoints", force: :cascade do |t|
    t.integer  "kpi_id"
    t.date     "date"
    t.decimal  "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "kpi_datapoints", ["kpi_id"], name: "index_kpi_datapoints_on_kpi_id"

  create_table "kpis", force: :cascade do |t|
    t.string   "name"
    t.string   "vector"
    t.string   "units"
    t.string   "frequency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "kpis_packs", id: false, force: :cascade do |t|
    t.integer "kpi_id"
    t.integer "pack_id"
  end

  add_index "kpis_packs", ["kpi_id"], name: "index_kpis_packs_on_kpi_id"
  add_index "kpis_packs", ["pack_id"], name: "index_kpis_packs_on_pack_id"

  create_table "meetings", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.integer  "division_id"
  end

  create_table "organisations", force: :cascade do |t|
    t.string   "name"
    t.string   "industry"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "packs", force: :cascade do |t|
    t.string   "title"
    t.string   "status"
    t.integer  "meeting_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
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

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",           null: false
    t.string   "encrypted_password",     default: "",           null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,            null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.boolean  "admin",                  default: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "role",                   default: "pack_owner"
    t.integer  "organisation_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
