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

ActiveRecord::Schema.define(version: 2022_08_08_070712) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "album_users", force: :cascade do |t|
    t.bigint "graduation_album_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["graduation_album_id"], name: "index_album_users_on_graduation_album_id"
    t.index ["user_id"], name: "index_album_users_on_user_id"
  end

  create_table "answers", force: :cascade do |t|
    t.bigint "rank_id", null: false
    t.bigint "rank_choice_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["rank_choice_id"], name: "index_answers_on_rank_choice_id"
    t.index ["rank_id"], name: "index_answers_on_rank_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "event_comments", force: :cascade do |t|
    t.text "body", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "event_id", null: false
    t.index ["event_id"], name: "index_event_comments_on_event_id"
    t.index ["user_id"], name: "index_event_comments_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.date "event_date"
    t.bigint "user_id", null: false
    t.bigint "graduation_album_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["graduation_album_id"], name: "index_events_on_graduation_album_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "graduation_albums", force: :cascade do |t|
    t.string "album_name", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "analysis_status", default: 0, null: false
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

  create_table "photo_collections", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "photo_paths", force: :cascade do |t|
    t.bigint "graduation_album_id", null: false
    t.string "path", null: false
    t.string "image_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "s3_file_name"
    t.integer "happy_score"
    t.index ["graduation_album_id"], name: "index_photo_paths_on_graduation_album_id"
  end

  create_table "rank_choices", force: :cascade do |t|
    t.string "content", null: false
    t.bigint "rank_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "answers_count", default: 0
    t.index ["rank_id"], name: "index_rank_choices_on_rank_id"
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

  create_table "registered_collections", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "collection_name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_registered_collections_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "follow_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["follow_id"], name: "index_relationships_on_follow_id"
    t.index ["user_id", "follow_id"], name: "index_relationships_on_user_id_and_follow_id", unique: true
    t.index ["user_id"], name: "index_relationships_on_user_id"
  end

  create_table "suprise_messages", force: :cascade do |t|
    t.bigint "graduation_album_id", null: false
    t.bigint "user_id", null: false
    t.string "suprise_title", null: false
    t.text "suprise_message", null: false
    t.date "suprise_time", null: false
    t.integer "state", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["graduation_album_id"], name: "index_suprise_messages_on_graduation_album_id"
    t.index ["user_id"], name: "index_suprise_messages_on_user_id"
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
    t.string "avatar"
    t.string "face_id"
    t.string "social_unique_id"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "album_users", "graduation_albums"
  add_foreign_key "album_users", "users"
  add_foreign_key "answers", "rank_choices"
  add_foreign_key "answers", "ranks"
  add_foreign_key "answers", "users"
  add_foreign_key "event_comments", "events"
  add_foreign_key "event_comments", "users"
  add_foreign_key "events", "graduation_albums"
  add_foreign_key "events", "users"
  add_foreign_key "graduation_albums", "users"
  add_foreign_key "message_for_each_menbers", "graduation_albums"
  add_foreign_key "message_for_each_menbers", "users"
  add_foreign_key "message_for_everyones", "graduation_albums"
  add_foreign_key "message_for_everyones", "users"
  add_foreign_key "photo_paths", "graduation_albums"
  add_foreign_key "rank_choices", "ranks"
  add_foreign_key "ranks", "graduation_albums"
  add_foreign_key "ranks", "users"
  add_foreign_key "registered_collections", "users"
  add_foreign_key "relationships", "users"
  add_foreign_key "relationships", "users", column: "follow_id"
  add_foreign_key "suprise_messages", "graduation_albums"
  add_foreign_key "suprise_messages", "users"
end
