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

ActiveRecord::Schema.define(:version => 20130415190708) do

  create_table "admin_users", :force => true do |t|
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

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "logo_url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "exchanges", :force => true do |t|
    t.string   "name"
    t.string   "logo_url"
    t.string   "symbol"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "exchanges_leagues", :id => false, :force => true do |t|
    t.integer  "exchange_id"
    t.integer  "league_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "exchanges_leagues", ["exchange_id", "league_id"], :name => "index_exchanges_leagues_on_exchange_id_and_league_id"

  create_table "leagues", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "category"
    t.string   "market"
    t.string   "algo_name"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "latest_registration_time"
    t.boolean  "invitation_only",          :default => false
    t.float    "buy_in"
    t.float    "commission"
    t.integer  "min_users"
    t.integer  "max_users"
  end

  create_table "stocks", :force => true do |t|
    t.string   "symbol"
    t.float    "latest_price"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "company_id"
    t.integer  "exchange_id"
  end

  create_table "user_accounts", :force => true do |t|
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "user_id",                      :null => false
    t.integer  "balance_cents", :default => 0, :null => false
  end

  add_index "user_accounts", ["user_id"], :name => "user_accounts_user_id_fk"

  create_table "user_league_associations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "league_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_payment_methods", :force => true do |t|
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.string   "type",                                :null => false
    t.string   "payment_gateway",                     :null => false
    t.string   "identifier"
    t.string   "info"
    t.integer  "account_id",                          :null => false
    t.boolean  "pending_approval", :default => false
  end

  add_index "user_payment_methods", ["account_id"], :name => "user_payment_methods_account_id_fk"

  create_table "user_transactions", :force => true do |t|
    t.integer  "payment_method_id",                :null => false
    t.integer  "amount_cents",      :default => 0, :null => false
    t.string   "type",                             :null => false
    t.string   "identifier",                       :null => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "user_transactions", ["payment_method_id"], :name => "user_transactions_payment_method_id_fk"

  create_table "users", :force => true do |t|
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  add_foreign_key "user_accounts", "users", :name => "user_accounts_user_id_fk"

  add_foreign_key "user_payment_methods", "user_accounts", :name => "user_payment_methods_account_id_fk", :column => "account_id"

  add_foreign_key "user_transactions", "user_payment_methods", :name => "user_transactions_payment_method_id_fk", :column => "payment_method_id"

end
