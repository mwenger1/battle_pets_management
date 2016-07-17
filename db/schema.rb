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

ActiveRecord::Schema.define(version: 20160717190304) do

  create_table "battle_pets", force: :cascade do |t|
    t.string   "name"
    t.integer  "strength"
    t.integer  "agility"
    t.integer  "wit"
    t.integer  "senses"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "trainer_id"
    t.index ["trainer_id"], name: "index_battle_pets_on_trainer_id"
  end

  create_table "trainers", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_trainers_on_name", unique: true
  end

end
