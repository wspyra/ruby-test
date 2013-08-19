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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130814114820) do

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "languages", :force => true do |t|
    t.string   "name"
    t.string   "code",       :limit => 3
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "languages", ["code"], :name => "index_languages_on_code"

  create_table "test_addons", :force => true do |t|
    t.integer  "test_id"
    t.string   "name"
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "test_addons", ["test_id"], :name => "index_test_addons_on_test_id"

  create_table "tests", :force => true do |t|
    t.string   "name"
    t.text     "data"
    t.integer  "position"
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
    t.boolean  "visible",                          :default => true
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "status_upload",      :limit => 12
    t.string   "status_mail",        :limit => 12
  end

  add_index "tests", ["position"], :name => "index_tests_on_position"
  add_index "tests", ["visible"], :name => "index_tests_on_visible"

end
