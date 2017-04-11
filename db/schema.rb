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

ActiveRecord::Schema.define(version: 20170410190624) do

  create_table "episodes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "tvshow_id"
    t.string   "imdb_id"
    t.string   "title"
    t.date     "released"
    t.integer  "episode"
    t.float    "imdb_rating", limit: 24
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["imdb_id"], name: "index_episodes_on_imdb_id", using: :btree
    t.index ["tvshow_id"], name: "index_episodes_on_tvshow_id", using: :btree
  end

  create_table "followed_episodes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "followed_tvshow_id"
    t.integer  "episodes_id"
    t.boolean  "status"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["episodes_id"], name: "index_followed_episodes_on_episodes_id", using: :btree
    t.index ["followed_tvshow_id"], name: "index_followed_episodes_on_followed_tvshow_id", using: :btree
  end

  create_table "followed_tvshows", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "tvshow_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tvshow_id"], name: "index_followed_tvshows_on_tvshow_id", using: :btree
    t.index ["user_id"], name: "index_followed_tvshows_on_user_id", using: :btree
  end

  create_table "tvshows", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "imdb_id"
    t.string   "title"
    t.integer  "year"
    t.string   "rated"
    t.date     "released"
    t.string   "runtime"
    t.string   "genre"
    t.string   "director"
    t.string   "writer"
    t.string   "actors"
    t.text     "plot",          limit: 65535
    t.string   "poster"
    t.float    "imdb_rating",   limit: 24
    t.integer  "imdb_votes"
    t.integer  "total_seasons"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["imdb_id"], name: "index_tvshows_on_imdb_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "uid"
    t.string   "name"
    t.string   "token"
    t.string   "secret"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "profile_image"
    t.index ["uid"], name: "index_users_on_uid", using: :btree
  end

  add_foreign_key "followed_episodes", "episodes", column: "episodes_id"
  add_foreign_key "followed_episodes", "followed_tvshows"
  add_foreign_key "followed_tvshows", "tvshows"
  add_foreign_key "followed_tvshows", "users"
end
