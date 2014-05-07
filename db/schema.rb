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

ActiveRecord::Schema.define(version: 20140507121155) do

  create_table "game_level_prompts", force: true do |t|
    t.integer "game_level_id", null: false
    t.text    "description",   null: false
    t.integer "appears_in",    null: false
  end

  create_table "game_levels", force: true do |t|
    t.integer "game_id",     null: false
    t.integer "sort",        null: false
    t.text    "description", null: false
    t.string  "code",        null: false
  end

  add_index "game_levels", ["game_id"], name: "index_game_levels_on_game_id", using: :btree

  create_table "game_owners", force: true do |t|
    t.integer "game_id", null: false
    t.integer "user_id", null: false
  end

  add_index "game_owners", ["game_id"], name: "index_game_owners_on_game_id", using: :btree
  add_index "game_owners", ["user_id", "game_id"], name: "index_game_owners_on_user_id_and_game_id", unique: true, using: :btree
  add_index "game_owners", ["user_id"], name: "index_game_owners_on_user_id", using: :btree

  create_table "games", force: true do |t|
    t.string   "title",       limit: 100, null: false
    t.text     "description",             null: false
    t.datetime "start"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "team_game_participations", force: true do |t|
    t.integer  "team_id",               null: false
    t.integer  "game_id",               null: false
    t.integer  "current_game_level_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "team_invitations", force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "team_id",    null: false
    t.integer  "type",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "team_members", force: true do |t|
    t.integer  "team_id",                    null: false
    t.integer  "user_id",                    null: false
    t.boolean  "active",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "team_members", ["team_id"], name: "index_team_members_on_team_id", using: :btree
  add_index "team_members", ["user_id", "team_id"], name: "index_team_members_on_user_id_and_team_id", using: :btree

  create_table "teams", force: true do |t|
    t.integer  "owner_id",   null: false
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "teams", ["owner_id"], name: "index_teams_on_owner_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "login",           limit: 20, null: false
    t.string   "email",           limit: 30, null: false
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["login"], name: "index_users_on_login", unique: true, using: :btree

end
