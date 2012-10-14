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

ActiveRecord::Schema.define(:version => 20121013181746) do

  create_table "admins", :force => true do |t|
    t.string   "username",               :default => ""
    t.string   "name",                   :default => ""
    t.string   "surname",                :default => ""
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true
  add_index "admins", ["username"], :name => "index_admins_on_username", :unique => true

  create_table "people", :force => true do |t|
    t.string   "name"
    t.string   "edrpou"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "people", ["edrpou"], :name => "index_people_on_edrpou", :unique => true

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username",               :default => ""
    t.string   "name",                   :default => ""
    t.string   "surname",                :default => ""
    t.string   "photo"
    t.integer  "role_id"
    t.boolean  "enabled",                :default => true
    t.string   "email",                  :default => ""
    t.string   "telephone"
    t.string   "encrypted_password",     :default => "",   :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

  create_table "vipiska_files", :force => true do |t|
    t.string   "file_name"
    t.string   "file_size"
    t.date     "file_for_data"
    t.integer  "files_count_in", :default => 0
    t.string   "download_count", :default => "0"
    t.date     "upload_at",      :default => '2012-10-01'
    t.integer  "user_id",        :default => 2
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

end
