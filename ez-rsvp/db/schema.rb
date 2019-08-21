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

ActiveRecord::Schema.define(version: 20190821093553) do

  create_table "events", force: :cascade do |t|
    t.string  "title"
    t.string  "location"
    t.date    "event_date"
    t.string  "start_time"
    t.string  "end_time"
    t.integer "user_id"
  end

  create_table "rsvps", force: :cascade do |t|
    t.integer "user_id"
    t.integer "event_id"
  end

  add_index "rsvps", ["event_id"], name: "index_rsvps_on_event_id"
  add_index "rsvps", ["user_id"], name: "index_rsvps_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
  end

end
