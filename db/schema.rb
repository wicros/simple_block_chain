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

ActiveRecord::Schema.define(version: 20190326023317) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blocks", force: :cascade do |t|
    t.string "current_hash", null: false
    t.string "previous_hash", null: false
    t.datetime "timestamp", null: false
    t.integer "difficulty", default: 0, null: false
    t.integer "nonce", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["current_hash"], name: "index_blocks_on_current_hash", unique: true
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "block_id"
    t.string "from", null: false
    t.string "to", null: false
    t.string "signature", null: false
    t.decimal "amount", precision: 12, scale: 6, null: false
    t.string "status", default: "unverified", null: false
    t.index ["block_id"], name: "index_transactions_on_block_id"
  end

end
