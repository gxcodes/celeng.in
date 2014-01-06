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

ActiveRecord::Schema.define(version: 20140106063730) do

  create_table "events", force: true do |t|
    t.string   "name"
    t.datetime "start_time"
    t.integer  "user_id"
    t.integer  "income",           default: 0
    t.integer  "outcome",          default: 0
    t.string   "description"
    t.integer  "target_saving_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "savings",          default: 0
  end

  create_table "target_savings", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "url"
    t.integer  "amount_target", default: 0
    t.integer  "price",         default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "deadline"
    t.integer  "user_id"
    t.string   "images"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "address"
    t.integer  "savings",                default: 0
    t.integer  "total_savings",          default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
