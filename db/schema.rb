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

ActiveRecord::Schema.define(version: 2019_11_18_192035) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_texts", force: :cascade do |t|
    t.string "field", null: false
    t.text "text", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "faqs", force: :cascade do |t|
    t.string "question", null: false
    t.text "answer", null: false
    t.integer "sorting", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "feedbacks", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.text "positives", null: false
    t.text "negatives", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orgs", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_orgs_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.bigint "org_id"
    t.string "title"
    t.string "subtitle"
    t.string "background_image"
    t.string "avatar_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token"
    t.index ["org_id"], name: "index_rooms_on_org_id"
  end

  create_table "user_orgs", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "org_id"
    t.boolean "owner", null: false
    t.boolean "member", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["org_id"], name: "index_user_orgs_on_org_id"
    t.index ["user_id"], name: "index_user_orgs_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "orgs", "users"
  add_foreign_key "rooms", "orgs"
  add_foreign_key "user_orgs", "orgs"
  add_foreign_key "user_orgs", "users"
end
