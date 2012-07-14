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

ActiveRecord::Schema.define(:version => 20120714175017) do

  create_table "calculated_game_player_statistics", :force => true do |t|
    t.integer  "count"
    t.integer  "statistic_type_id"
    t.integer  "game_id"
    t.integer  "team_id"
    t.integer  "player_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "calculated_game_statistics", :force => true do |t|
    t.integer  "count"
    t.integer  "statistic_type_id"
    t.integer  "team_id"
    t.integer  "game_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "game_rosters", :force => true do |t|
    t.integer  "player_id"
    t.integer  "team_id"
    t.integer  "game_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "games", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "home_team_id"
    t.integer  "visiting_team_id"
  end

  create_table "players", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "team_id"
  end

  create_table "statistic_types", :force => true do |t|
    t.string   "code"
    t.integer  "points"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_reported_statistics", :force => true do |t|
    t.integer  "statistic_type_id"
    t.integer  "game_id"
    t.integer  "team_id"
    t.integer  "player_id"
    t.integer  "user_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "user_reported_statistics", ["game_id"], :name => "index_user_reported_statistics_on_game_id"
  add_index "user_reported_statistics", ["player_id"], :name => "index_user_reported_statistics_on_player_id"
  add_index "user_reported_statistics", ["statistic_type_id"], :name => "index_user_reported_statistics_on_statistic_type_id"
  add_index "user_reported_statistics", ["team_id"], :name => "index_user_reported_statistics_on_team_id"
  add_index "user_reported_statistics", ["user_id"], :name => "index_user_reported_statistics_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "twitter_id"
    t.string   "twitter_screen_name"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

end
