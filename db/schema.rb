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

ActiveRecord::Schema.define(version: 20140426191214) do

  create_table "notes", force: true do |t|
    t.string   "content",     limit: 4000
    t.datetime "archived_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: true do |t|
    t.integer "tag_id"
    t.integer "note_id"
    t.integer "position"
  end

  add_index "taggings", ["tag_id", "note_id", "position"], name: "index_taggings_on_tag_id_and_note_id_and_position", unique: true, using: :btree

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "archived_at"
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

end
