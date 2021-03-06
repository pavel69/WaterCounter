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

ActiveRecord::Schema.define(version: 20131018052628) do

  create_table "counters", force: true do |t|
    t.date     "date"
    t.integer  "warm"
    t.integer  "cold"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "prev_id"
    t.integer  "warm_consumption"
    t.integer  "cold_consumption"
    t.integer  "prev_warm_consumption"
    t.integer  "prev_cold_consumption"
    t.integer  "year"
  end

  add_index "counters", ["date"], name: "index_counters_on_date", unique: true

end
