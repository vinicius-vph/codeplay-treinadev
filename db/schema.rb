ActiveRecord::Schema.define(version: 2021_05_14_183446) do

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "code"
    t.decimal "price"
    t.date "enrollment_deadline"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
