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

ActiveRecord::Schema[7.0].define(version: 2023_06_27_134727) do
  create_table "accounts", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone"
    t.string "address1"
    t.string "address2"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "accounttype"
    t.datetime "created_at", default: -> { "current_timestamp(6)" }, null: false
    t.datetime "updated_at", default: -> { "current_timestamp(6)" }, null: false
    t.boolean "admin", default: false
  end

  create_table "managers", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.string "address1"
    t.string "address2"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "account_type"
    t.boolean "admin"
    t.index ["email"], name: "index_managers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_managers_on_reset_password_token", unique: true
  end

  create_table "owners", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone"
    t.string "address1"
    t.string "address2"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "ownertype"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name"
    t.string "user_type"
    t.string "passphrase"
    t.integer "manager_id"
    t.string "zone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "zone_id"
    t.index ["manager_id"], name: "index_users_on_manager_id"
    t.index ["zone_id"], name: "index_users_on_zone_id"
  end

  create_table "userzones", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.integer "zone_id"
    t.string "pmk"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "manager_id"
    t.index ["manager_id"], name: "index_userzones_on_manager_id"
    t.index ["zone_id"], name: "index_userzones_on_zone_id"
  end

  create_table "wificlients", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "location"
    t.string "ipaddress"
    t.string "version"
    t.string "os"
    t.string "model"
    t.string "status"
    t.decimal "pollrate", precision: 10
    t.datetime "lastseen"
    t.string "note"
    t.string "name"
    t.datetime "dateadded"
    t.string "confighash"
    t.boolean "enabled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "mac"
    t.string "serial"
    t.integer "manager_id"
    t.string "country"
    t.string "wlan_name"
    t.index ["manager_id"], name: "index_wificlients_on_manager_id"
  end

  create_table "wlanclients", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "location"
    t.string "ipaddress"
    t.string "clientversion"
    t.string "osversion"
    t.string "hwmodel"
    t.string "status"
    t.decimal "pollrate", precision: 10
    t.datetime "lastseen"
    t.string "note"
    t.string "name"
    t.datetime "dateadded"
    t.string "confighash"
    t.decimal "ownerid", precision: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "enabled"
  end

  create_table "wlans", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "mac"
    t.string "name"
    t.string "description"
    t.string "status"
    t.string "wlan"
    t.string "phy"
    t.string "txpower"
    t.string "a"
    t.string "g"
    t.datetime "lastseen"
    t.datetime "dateadded"
    t.integer "channel"
    t.integer "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "selected_a"
    t.string "selected_g"
    t.integer "manager_id"
    t.string "client_name"
    t.boolean "enabled"
    t.string "zone"
    t.index ["client_id"], name: "index_wlans_on_client_id"
    t.index ["manager_id"], name: "index_wlans_on_manager_id"
  end

  create_table "zones", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "ssid"
    t.boolean "open_ap"
    t.integer "manager_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["manager_id"], name: "index_zones_on_manager_id"
  end

end
