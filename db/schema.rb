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

ActiveRecord::Schema.define(version: 2021_02_21_074605) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.string "venue", null: false
    t.string "tournament_phase", null: false
    t.string "home_team_name", null: false
    t.string "guest_team_name", null: false
    t.integer "home_team_score", default: 0, null: false
    t.integer "guest_team_score", default: 0, null: false
    t.datetime "kickoff_at", null: false
    t.datetime "final_whistle_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tournament_phase", "home_team_name", "guest_team_name"], name: "index_phase_home_guest", unique: true
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_tournaments_on_name", unique: true
  end

end
