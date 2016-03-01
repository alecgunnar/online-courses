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

ActiveRecord::Schema.define(version: 20160301012221) do

  create_table "assessments", force: :cascade do |t|
    t.string  "name",            limit: 255
    t.string  "specs_file_name", limit: 255
    t.integer "submit_limit",    limit: 4
    t.string  "context",         limit: 255, null: false
    t.integer "instructor",      limit: 4
  end

  add_index "assessments", ["context"], name: "index_assessments_on_context", unique: true, using: :btree

  create_table "driver_submission_files", force: :cascade do |t|
    t.integer "submission_id",       limit: 4
    t.integer "test_driver_file_id", limit: 4
    t.string  "path",                limit: 255
  end

  add_index "driver_submission_files", ["submission_id"], name: "index_driver_submission_files_on_submission_id", using: :btree
  add_index "driver_submission_files", ["test_driver_file_id"], name: "index_driver_submission_files_on_test_driver_file_id", using: :btree

  create_table "submissions", force: :cascade do |t|
    t.integer "user_id",       limit: 4
    t.integer "assessment_id", limit: 4
    t.decimal "grade",                   precision: 10
  end

  add_index "submissions", ["assessment_id"], name: "index_submissions_on_assessment_id", using: :btree
  add_index "submissions", ["user_id"], name: "index_submissions_on_user_id", using: :btree

  create_table "test_driver_files", force: :cascade do |t|
    t.integer "test_driver_id", limit: 4
    t.string  "name",           limit: 255
  end

  add_index "test_driver_files", ["test_driver_id"], name: "index_test_driver_files_on_test_driver_id", using: :btree

  create_table "test_drivers", force: :cascade do |t|
    t.integer "assessment_id", limit: 4
    t.string  "name",          limit: 255
    t.decimal "points",                    precision: 10
  end

  add_index "test_drivers", ["assessment_id"], name: "index_test_drivers_on_assessment_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string "first_name", limit: 255
    t.string "last_name",  limit: 255
    t.string "email",      limit: 255
    t.string "org_id",     limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["org_id"], name: "index_users_on_org_id", unique: true, using: :btree

end
