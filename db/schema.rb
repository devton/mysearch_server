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

ActiveRecord::Schema.define(version: 20150206014727) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "crawled_urls", force: :cascade do |t|
    t.string   "url_scheme",                     null: false
    t.text     "host",                           null: false
    t.text     "path",                           null: false
    t.text     "fragment"
    t.text     "query_strings",                               array: true
    t.datetime "last_parsed_at"
    t.datetime "last_check_at"
    t.boolean  "dead",           default: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "crawled_urls", ["host"], name: "index_crawled_urls_on_host", using: :btree

  create_table "negative_expressions", force: :cascade do |t|
    t.text     "domains",     null: false, array: true
    t.text     "expressions", null: false, array: true
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
