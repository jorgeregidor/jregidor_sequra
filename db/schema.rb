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

ActiveRecord::Schema[7.2].define(version: 2024_10_08_125720) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "merchants", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "reference", null: false
    t.string "email"
    t.date "live_on", null: false
    t.string "disbursement_frequency", null: false
    t.integer "disbursement_wday"
    t.integer "minimum_monthly_fee_cents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["disbursement_frequency"], name: "index_merchants_on_disbursement_frequency"
    t.index ["reference"], name: "index_merchants_on_reference", unique: true
  end
end
