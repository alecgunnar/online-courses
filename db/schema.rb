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

ActiveRecord::Schema.define(version: 20160202195832) do

  create_table "assessments", force: :cascade do |t|
    t.string  "context_id",   limit: 255, null: false
    t.string  "label",        limit: 255
    t.integer "submit_limit", limit: 4
  end

  add_index "assessments", ["context_id"], name: "index_assessments_on_context_id", unique: true, using: :btree

end
