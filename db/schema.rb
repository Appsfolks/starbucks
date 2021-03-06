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

ActiveRecord::Schema.define(:version => 20110322173053) do

  create_table "cities", :force => true do |t|
    t.integer "state_id"
    t.string  "name"
  end

  add_index "cities", ["name"], :name => "index_cities_on_name"
  add_index "cities", ["state_id"], :name => "index_cities_on_state_id"

  create_table "comments", :force => true do |t|
    t.integer  "commentable_id",   :default => 0
    t.string   "commentable_type", :default => ""
    t.string   "title",            :default => ""
    t.text     "body"
    t.string   "subject",          :default => ""
    t.integer  "user_id",          :default => 0,  :null => false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "likes",            :default => 0
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "countries", :force => true do |t|
    t.string "name"
    t.string "abbr"
  end

  add_index "countries", ["abbr"], :name => "index_countries_on_abbr"
  add_index "countries", ["name"], :name => "index_countries_on_name"

  create_table "events", :force => true do |t|
    t.string   "name"
    t.string   "category"
    t.text     "description"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "address1"
    t.string   "address2"
    t.string   "zipcode"
    t.string   "organizer"
    t.integer  "user_id"
    t.string   "featured"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "city_id"
    t.integer  "state_id"
    t.integer  "country_id"
  end

  add_index "events", ["city_id"], :name => "index_events_on_city_id"
  add_index "events", ["country_id"], :name => "index_events_on_country_id"
  add_index "events", ["state_id"], :name => "index_events_on_state_id"

  create_table "friends_users", :id => false, :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
  end

  create_table "posts", :force => true do |t|
    t.text     "post_content"
    t.string   "post_type"
    t.integer  "receiver_id"
    t.integer  "user_id"
    t.integer  "classroom_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "likes"
  end

  create_table "profiles", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.date     "birth_day"
    t.integer  "user_id_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "slug"
  end

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "sequence", "scope"], :name => "index_slugs_on_n_s_s_and_s", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "states", :force => true do |t|
    t.integer "country_id"
    t.string  "name"
    t.string  "abbr"
  end

  add_index "states", ["abbr"], :name => "index_states_on_abbr"
  add_index "states", ["country_id"], :name => "index_states_on_country_id"
  add_index "states", ["name"], :name => "index_states_on_name"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_hash"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cached_slug"
    t.integer  "fb_user_id",    :limit => 8
  end

end
