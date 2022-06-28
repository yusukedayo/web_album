# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_06_28_065950) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.date "event_date"
    t.bigint "user_id", null: false
    t.bigint "graduation_album_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.json "event_photos"
    t.index ["graduation_album_id"], name: "index_events_on_graduation_album_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "graduation_albums", force: :cascade do |t|
    t.string "title", null: false
    t.string "album_name", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.json "photos"
    t.index ["user_id"], name: "index_graduation_albums_on_user_id"
  end

  create_table "message_for_each_menbers", force: :cascade do |t|
    t.text "body", null: false
    t.bigint "user_id", null: false
    t.bigint "graduation_album_id", null: false
    t.integer "to_user", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["graduation_album_id"], name: "index_message_for_each_menbers_on_graduation_album_id"
    t.index ["user_id"], name: "index_message_for_each_menbers_on_user_id"
  end

  create_table "message_for_everyones", force: :cascade do |t|
    t.text "body", null: false
    t.bigint "user_id", null: false
    t.bigint "graduation_album_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["graduation_album_id"], name: "index_message_for_everyones_on_graduation_album_id"
    t.index ["user_id"], name: "index_message_for_everyones_on_user_id"
  end

  create_table "ranks", force: :cascade do |t|
    t.string "rank_title", null: false
    t.text "rank_description", null: false
    t.bigint "user_id", null: false
    t.bigint "graduation_album_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["graduation_album_id"], name: "index_ranks_on_graduation_album_id"
    t.index ["user_id"], name: "index_ranks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "events", "graduation_albums"
  add_foreign_key "events", "users"
  add_foreign_key "graduation_albums", "users"
  add_foreign_key "message_for_each_menbers", "graduation_albums"
  add_foreign_key "message_for_each_menbers", "users"
  add_foreign_key "message_for_everyones", "graduation_albums"
  add_foreign_key "message_for_everyones", "users"
  add_foreign_key "ranks", "graduation_albums"
  add_foreign_key "ranks", "users"
end
