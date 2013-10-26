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

ActiveRecord::Schema.define(:version => 20131026013105) do

  create_table "accounts", :force => true do |t|
    t.string   "plan_id"
    t.integer  "user_id"
    t.string   "stripe_customer_token"
    t.string   "email"
    t.boolean  "is_active"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.integer  "studio_id"
  end

  add_index "accounts", ["studio_id"], :name => "index_accounts_on_studio_id"
  add_index "accounts", ["user_id", "studio_id"], :name => "index_accounts_on_user_id_and_studio_id", :unique => true
  add_index "accounts", ["user_id"], :name => "index_accounts_on_user_id"

  create_table "availabilities", :force => true do |t|
    t.time     "start_at"
    t.time     "end_at"
    t.integer  "day_of_week"
    t.integer  "profile_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "availabilities", ["profile_id"], :name => "index_availabilities_on_profile_id"

  create_table "charges", :force => true do |t|
    t.integer  "studio_id"
    t.integer  "user_id"
    t.string   "stripe_card_token"
    t.integer  "amount"
    t.string   "description"
    t.string   "email"
    t.string   "title"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "coupons", :force => true do |t|
    t.integer  "studio_id"
    t.integer  "user_id"
    t.string   "duration"
    t.integer  "amount_off"
    t.integer  "duration_in_months"
    t.integer  "max_redemptions"
    t.integer  "percent_off"
    t.datetime "redeem_by"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "resource_id"
    t.string   "resource_type"
  end

  create_table "credits", :force => true do |t|
    t.integer  "studio_id"
    t.integer  "customer_id"
    t.integer  "quantity"
    t.datetime "expires_at"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "credits", ["customer_id"], :name => "index_credits_on_customer_id"

  create_table "customers", :force => true do |t|
    t.string   "stripe_customer_token"
    t.string   "last_4_digits"
    t.string   "plan_id"
    t.integer  "quantity"
    t.datetime "trial_end_at"
    t.string   "email"
    t.string   "coupon_code"
    t.string   "description"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "access_token"
    t.string   "refresh_token"
    t.string   "stripe_publishable_key"
    t.string   "stripe_user_id"
    t.integer  "profile_id"
  end

  create_table "events", :force => true do |t|
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer  "instructor_id"
    t.text     "description"
    t.string   "title"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "studio_id"
    t.boolean  "archive"
    t.integer  "price"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.string   "url"
    t.string   "custom_url"
    t.boolean  "canceled"
    t.integer  "location_id"
  end

  create_table "instructors", :force => true do |t|
    t.integer  "user_id"
    t.integer  "studio_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "instructors", ["studio_id"], :name => "index_instructors_on_studio_id"
  add_index "instructors", ["user_id", "studio_id"], :name => "index_instructors_on_user_id_and_studio_id", :unique => true
  add_index "instructors", ["user_id"], :name => "index_instructors_on_user_id"

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.integer  "studio_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
  end

  add_index "locations", ["studio_id"], :name => "index_locations_on_studio_id"

  create_table "memberships", :force => true do |t|
    t.integer  "studio_id"
    t.string   "name"
    t.integer  "price"
    t.string   "interval"
    t.integer  "interval_count"
    t.integer  "trial_period_days"
    t.text     "description"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.string   "title"
    t.boolean  "one_time_app",      :default => false
    t.boolean  "prorate",           :default => false
    t.integer  "resource_id"
    t.string   "resource_type"
  end

  create_table "packages", :force => true do |t|
    t.integer  "studio_id"
    t.integer  "quantity"
    t.integer  "percent_off"
    t.string   "name"
    t.string   "title"
    t.integer  "price"
    t.boolean  "archived"
    t.datetime "expires_at"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "interval"
    t.integer  "interval_count"
    t.integer  "resource_id"
    t.string   "resource_type"
  end

  add_index "packages", ["studio_id"], :name => "index_packages_on_studio_id"

  create_table "photos", :force => true do |t|
    t.string   "name"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "profiles", :force => true do |t|
    t.integer  "phone",                    :limit => 8
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.text     "description"
    t.boolean  "is_certified"
    t.boolean  "is_available"
    t.boolean  "hide_map"
    t.integer  "user_id"
    t.datetime "dob"
    t.string   "emergency_contact_name"
    t.integer  "emergency_contact_number"
    t.string   "name"
    t.string   "email"
    t.integer  "max_distance"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
    t.string   "certification"
    t.boolean  "is_not_available",                      :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "student_waiver"
  end

  add_index "profiles", ["email"], :name => "index_profiles_on_email", :unique => true

  create_table "profiles_roles", :id => false, :force => true do |t|
    t.integer "profile_id"
    t.integer "role_id"
  end

  add_index "profiles_roles", ["profile_id", "role_id"], :name => "index_profiles_roles_on_profile_id_and_role_id"

  create_table "purchases", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "product_id"
    t.integer  "studio_id"
    t.string   "product_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "final_price"
    t.boolean  "discount_applied"
  end

  add_index "purchases", ["customer_id", "product_id", "studio_id", "product_type"], :name => "studio_purchases", :unique => true
  add_index "purchases", ["customer_id"], :name => "index_purchases_on_customer_id"
  add_index "purchases", ["product_id"], :name => "index_purchases_on_product_id"
  add_index "purchases", ["studio_id"], :name => "index_purchases_on_studio_id"

  create_table "registered_events", :force => true do |t|
    t.integer  "profile_id"
    t.integer  "event_id"
    t.integer  "studio_id"
    t.boolean  "attended",            :default => false
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.boolean  "canceled_by_student", :default => false
    t.boolean  "redeemed",            :default => false
    t.string   "payment_method"
  end

  add_index "registered_events", ["event_id"], :name => "index_registered_events_on_event_id"
  add_index "registered_events", ["profile_id", "event_id", "studio_id"], :name => "student_events", :unique => true
  add_index "registered_events", ["profile_id"], :name => "index_registered_events_on_profile_id"
  add_index "registered_events", ["studio_id"], :name => "index_registered_events_on_studio_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "students", :force => true do |t|
    t.integer  "profile_id"
    t.integer  "resource_id"
    t.boolean  "signed_waiver"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "resource_type"
  end

  add_index "students", ["profile_id"], :name => "index_students_on_profile_id"

  create_table "studios", :force => true do |t|
    t.string   "name"
    t.integer  "main_phone",          :limit => 8
    t.string   "website"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "account_id"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.text     "student_waiver"
    t.text     "instructor_waiver"
    t.text     "cancellation_policy"
    t.integer  "default_event_price"
    t.text     "description"
  end

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
    t.string   "name"
    t.string   "stripe_code"
    t.integer  "active_role_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

  create_table "views", :force => true do |t|
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

  add_index "views", ["email"], :name => "index_views_on_email", :unique => true
  add_index "views", ["reset_password_token"], :name => "index_views_on_reset_password_token", :unique => true

end
