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

ActiveRecord::Schema[7.0].define(version: 2020_11_05_011856) do
  create_table "project_sites", force: :cascade do |t|
    t.integer "project_id"
    t.integer "site_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "project_name"
    t.text "project_details"
    t.string "permit"
    t.date "start_date"
    t.date "end_date"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "sites", force: :cascade do |t|
    t.string "site_name"
    t.text "site_description"
    t.decimal "latitude"
    t.decimal "longitude"
    t.string "color"
    t.boolean "shared"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sites_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "last_name"
    t.string "institution"
    t.string "email"
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "contributor", default: false
    t.boolean "editor", default: false
    t.boolean "admin", default: false
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at", precision: nil
    t.string "reset_digest"
    t.datetime "reset_sent_at", precision: nil
    t.datetime "last_seen_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "projects", "users"
  add_foreign_key "sites", "users"
end
