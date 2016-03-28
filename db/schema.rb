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

ActiveRecord::Schema.define(version: 20160319015008) do

  create_table "assessments", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "specs_file",   limit: 255
    t.integer  "submit_limit", limit: 4
    t.string   "context",      limit: 255
    t.integer  "user_id",      limit: 4
    t.text     "description",  limit: 65535
    t.datetime "due_date"
    t.integer  "points",       limit: 4,     default: 0
    t.integer  "consumer_id",  limit: 4
  end

  add_index "assessments", ["consumer_id"], name: "index_assessments_on_consumer_id", using: :btree
  add_index "assessments", ["context"], name: "index_assessments_on_context", using: :btree
  add_index "assessments", ["user_id"], name: "index_assessments_on_user_id", using: :btree

  create_table "consumers", force: :cascade do |t|
    t.string "key",         limit: 255
    t.string "outcome_url", limit: 255
  end

  add_index "consumers", ["key"], name: "index_consumers_on_key", unique: true, using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "final_grades", force: :cascade do |t|
    t.integer "user_id",       limit: 4
    t.integer "assessment_id", limit: 4
    t.integer "submission_id", limit: 4
  end

  add_index "final_grades", ["assessment_id"], name: "index_final_grades_on_assessment_id", using: :btree
  add_index "final_grades", ["submission_id"], name: "index_final_grades_on_submission_id", using: :btree
  add_index "final_grades", ["user_id"], name: "index_final_grades_on_user_id", using: :btree

  create_table "submissions", force: :cascade do |t|
    t.integer  "user_id",          limit: 4
    t.integer  "assessment_id",    limit: 4
    t.string   "file",             limit: 255
    t.datetime "upload_date"
    t.decimal  "grade",                        precision: 10, default: 0
    t.boolean  "grade_approved",   limit: 1,                  default: false
    t.boolean  "graded",           limit: 1,                  default: false
    t.string   "result_sourcedid", limit: 255
  end

  add_index "submissions", ["assessment_id"], name: "index_submissions_on_assessment_id", using: :btree
  add_index "submissions", ["user_id"], name: "index_submissions_on_user_id", using: :btree

  create_table "test_driver_files", force: :cascade do |t|
    t.integer "test_driver_id", limit: 4
    t.string  "name",           limit: 255
    t.decimal "points",                     precision: 10
    t.string  "file",           limit: 255
    t.boolean "downloadable",   limit: 1,                  default: true
  end

  add_index "test_driver_files", ["test_driver_id"], name: "index_test_driver_files_on_test_driver_id", using: :btree

  create_table "test_driver_result_files", force: :cascade do |t|
    t.integer "test_driver_result_id", limit: 4
    t.integer "test_driver_file_id",   limit: 4
    t.string  "path",                  limit: 255
    t.decimal "grade",                             precision: 10
  end

  add_index "test_driver_result_files", ["test_driver_file_id"], name: "index_test_driver_result_files_on_test_driver_file_id", using: :btree
  add_index "test_driver_result_files", ["test_driver_result_id"], name: "index_test_driver_result_files_on_test_driver_result_id", using: :btree

  create_table "test_driver_results", force: :cascade do |t|
    t.integer "submission_id",  limit: 4
    t.integer "test_driver_id", limit: 4
    t.text    "output",         limit: 65535
    t.text    "error",          limit: 65535
    t.text    "feedback",       limit: 65535
    t.decimal "grade",                        precision: 10
    t.boolean "success",        limit: 1,                    default: false
  end

  add_index "test_driver_results", ["submission_id"], name: "index_test_driver_results_on_submission_id", using: :btree
  add_index "test_driver_results", ["test_driver_id"], name: "index_test_driver_results_on_test_driver_id", using: :btree

  create_table "test_drivers", force: :cascade do |t|
    t.integer "assessment_id",  limit: 4
    t.string  "name",           limit: 255
    t.decimal "points",                     precision: 10
    t.string  "file",           limit: 255
    t.boolean "downloadable",   limit: 1,                  default: false
    t.boolean "share_feedback", limit: 1,                  default: true
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
