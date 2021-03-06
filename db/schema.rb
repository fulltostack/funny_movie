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

ActiveRecord::Schema.define(version: 2019_07_19_050657) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "youtube_video_votes", force: :cascade do |t|
    t.bigint "youtube_video_id"
    t.bigint "user_id"
    t.integer "vote"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_youtube_video_votes_on_user_id"
    t.index ["youtube_video_id"], name: "index_youtube_video_votes_on_youtube_video_id"
  end

  create_table "youtube_videos", force: :cascade do |t|
    t.bigint "user_id"
    t.string "url"
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_youtube_videos_on_user_id"
  end

  add_foreign_key "youtube_video_votes", "users"
  add_foreign_key "youtube_video_votes", "youtube_videos"
  add_foreign_key "youtube_videos", "users"
end
