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

ActiveRecord::Schema.define(:version => 20130407133251) do

  create_table "pay_items", :force => true do |t|
    t.integer  "user_id"
    t.string   "payment_type",   :default => "HOURLY"
    t.float    "unit_amount"
    t.float    "quantity"
    t.float    "total"
    t.boolean  "active",         :default => true
    t.date     "effective_date"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  add_index "pay_items", ["user_id"], :name => "index_pay_items_on_user_id"

  create_table "payments", :force => true do |t|
    t.float    "amount",             :default => 0.0
    t.float    "amount_withheld",    :default => 0.0
    t.float    "net",                :default => 0.0
    t.float    "payroll_tax_amount", :default => 0.0
    t.string   "payment_type",       :default => "DWOLLA"
    t.integer  "user_id"
    t.boolean  "payment_made"
    t.date     "payment_date"
    t.boolean  "active"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  add_index "payments", ["user_id"], :name => "index_payments_on_user_id"

  create_table "salaries", :force => true do |t|
    t.integer  "user_id"
    t.string   "salary_type",       :default => "EXEMPT"
    t.float    "rate",              :default => 0.0
    t.string   "payment_frequency", :default => "BIWEEKLY"
    t.date     "effective_from"
    t.date     "effective_to"
    t.boolean  "active",            :default => true
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "salaries", ["user_id"], :name => "index_salaries_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.string   "country"
    t.string   "email"
    t.string   "username"
    t.string   "password_hash"
    t.string   "salt"
    t.string   "auth_key"
    t.string   "ssn"
    t.string   "dwolla_id"
    t.boolean  "active"
    t.boolean  "is_manager"
    t.datetime "last_login"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "registration_state", :default => "NEW"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["username"], :name => "index_users_on_username"

  create_table "withholdings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "allowances_claimed",            :default => 0
    t.float    "additional_withholding_amount", :default => 0.0
    t.boolean  "is_exempt",                     :default => false
    t.boolean  "is_married",                    :default => false
    t.string   "formula_file",                  :default => "us/ny/nyc_exempt.rb"
    t.boolean  "active",                        :default => false
    t.date     "effective_from"
    t.date     "effective_to"
    t.datetime "created_at",                                                       :null => false
    t.datetime "updated_at",                                                       :null => false
  end

  add_index "withholdings", ["user_id"], :name => "index_withholdings_on_user_id"

end
