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

ActiveRecord::Schema.define(version: 20170409163947) do

  create_table "episodes", force: :cascade do |t|
    t.string   "imdb_id"
    t.integer  "tvshow_id"
    t.string   "title"
    t.date     "released"
    t.integer  "episode"
    t.float    "imdb_rating"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["imdb_id"], name: "index_episodes_on_imdb_id"
    t.index ["tvshow_id"], name: "index_episodes_on_tvshow_id"
  end

  create_table "tvshows", force: :cascade do |t|
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
    t.text     "plot"
    t.string   "poster"
    t.float    "imdb_rating"
    t.integer  "imdb_votes"
    t.integer  "total_seasons"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["imdb_id"], name: "index_tvshows_on_imdb_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "uid"
    t.string   "name"
    t.string   "token"
    t.string   "secret"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_users_on_uid"
  end

  create_table "watched_episodes", force: :cascade do |t|
    t.integer  "watched_tv_show_id"
    t.integer  "episode_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["episode_id"], name: "index_watched_episodes_on_episode_id"
    t.index ["watched_tv_show_id"], name: "index_watched_episodes_on_watched_tv_show_id"
  end

  create_table "watched_tv_shows", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "tvshow_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tvshow_id"], name: "index_watched_tv_shows_on_tvshow_id"
    t.index ["user_id"], name: "index_watched_tv_shows_on_user_id"
  end

end
