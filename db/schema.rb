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

ActiveRecord::Schema.define(:version => 20130503170124) do

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

  create_table "bids", :force => true do |t|
    t.integer  "user_league_association_id"
    t.string   "type"
    t.integer  "stock_id"
    t.integer  "amount"
    t.integer  "trade_id"
    t.integer  "price_cents",                :default => 0,     :null => false
    t.string   "price_currency",             :default => "USD", :null => false
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
  end

  add_index "bids", ["stock_id"], :name => "bids_stock_id_fk"
  add_index "bids", ["trade_id"], :name => "bids_trade_id_fk"
  add_index "bids", ["user_league_association_id"], :name => "bids_user_league_association_id_fk"

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "logo_url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

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

  add_index "exchanges_leagues", ["exchange_id", "league_id"], :name => "index_exchanges_leagues_on_exchange_id_and_league_id", :unique => true

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
    t.integer  "latest_registration_time"
    t.boolean  "invitation_only",          :default => false
    t.float    "buy_in"
    t.float    "commission"
    t.integer  "min_users"
    t.integer  "max_users"
    t.boolean  "completed",                :default => false
    t.integer  "virtual_money_cents",      :default => 0,     :null => false
    t.string   "virtual_money_currency",   :default => "USD", :null => false
    t.integer  "start_job_id"
    t.integer  "end_job_id"
  end

  create_table "notifications", :force => true do |t|
    t.boolean  "read",        :default => false, :null => false
    t.integer  "user_id",                        :null => false
    t.integer  "entity_id",                      :null => false
    t.string   "entity_type",                    :null => false
    t.string   "message"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "stocks", :force => true do |t|
    t.string   "symbol"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.integer  "company_id"
    t.integer  "exchange_id"
    t.integer  "latest_price_cents",    :default => 0,     :null => false
    t.string   "latest_price_currency", :default => "USD", :null => false
    t.float    "change"
    t.float    "percentage_change"
  end

  create_table "trades", :force => true do |t|
    t.integer  "stock_id"
    t.integer  "amount"
    t.integer  "price_cents",                :default => 0,     :null => false
    t.string   "price_currency",             :default => "USD", :null => false
    t.integer  "user_league_association_id"
    t.string   "type"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.boolean  "system_created"
  end

  add_index "trades", ["stock_id"], :name => "trades_stock_id_fk"
  add_index "trades", ["user_league_association_id"], :name => "trades_user_league_association_id_fk"

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
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "balance_cents",       :default => 0,     :null => false
    t.string   "balance_currency",    :default => "USD", :null => false
    t.integer  "rank"
    t.integer  "investment_cents",    :default => 0,     :null => false
    t.string   "investment_currency", :default => "USD", :null => false
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

  create_table "user_stock_associations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "stock_id"
    t.boolean  "recently_searched"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "user_stock_associations", ["user_id", "stock_id"], :name => "index_users_user_stock_associations_on_user_id_and_stock_id", :unique => true

  create_table "user_transactions", :force => true do |t|
    t.integer  "payment_method_id"
    t.integer  "amount_cents",               :default => 0, :null => false
    t.string   "type",                                      :null => false
    t.string   "identifier",                                :null => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.integer  "account_id",                                :null => false
    t.integer  "user_league_association_id"
  end

  add_index "user_transactions", ["account_id"], :name => "user_transactions_account_id_fk"
  add_index "user_transactions", ["payment_method_id"], :name => "user_transactions_payment_method_id_fk"
  add_index "user_transactions", ["user_league_association_id"], :name => "user_transactions_user_league_association_id_fk"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",   :null => false
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "user_name"
    t.string   "phone_number"
    t.string   "time_zone"
    t.boolean  "notifications_enabled",  :default => true
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_profiles", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_foreign_key "bids", "stocks", :name => "bids_stock_id_fk"
  add_foreign_key "bids", "trades", :name => "bids_trade_id_fk"
  add_foreign_key "bids", "user_league_associations", :name => "bids_user_league_association_id_fk"

  add_foreign_key "trades", "stocks", :name => "trades_stock_id_fk"
  add_foreign_key "trades", "user_league_associations", :name => "trades_user_league_association_id_fk"

  add_foreign_key "user_accounts", "users", :name => "user_accounts_user_id_fk"

  add_foreign_key "user_payment_methods", "user_accounts", :name => "user_payment_methods_account_id_fk", :column => "account_id"

  add_foreign_key "user_transactions", "user_accounts", :name => "user_transactions_account_id_fk", :column => "account_id"
  add_foreign_key "user_transactions", "user_league_associations", :name => "user_transactions_user_league_association_id_fk"
  add_foreign_key "user_transactions", "user_payment_methods", :name => "user_transactions_payment_method_id_fk", :column => "payment_method_id"

end
