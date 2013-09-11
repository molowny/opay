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

ActiveRecord::Schema.define(version: 20130326152550) do

  create_table "opay_payments", force: true do |t|
    t.integer  "payable_id"
    t.string   "payable_type"
    t.string   "session_id",                   null: false
    t.string   "provider",                     null: false
    t.integer  "amount",                       null: false
    t.boolean  "finished",     default: false, null: false
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "opay_payments", ["payable_id", "payable_type"], name: "index_opay_payments_on_payable_id_and_payable_type"
  add_index "opay_payments", ["session_id"], name: "index_opay_payments_on_session_id", unique: true

  create_table "orders", force: true do |t|
    t.string   "name"
    t.string   "amount"
    t.boolean  "finished",   default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
