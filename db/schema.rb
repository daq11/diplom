# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141514174730) do

  create_table "afiles", force: true do |t|
    t.integer  "document_id"
    t.binary   "source"
    t.string   "path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "afiles", ["document_id"], name: "index_afiles_on_document_id"

  create_table "answers", force: true do |t|
    t.text     "text"
    t.integer  "user_id"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id"
  add_index "answers", ["user_id"], name: "index_answers_on_user_id"

  create_table "documents", force: true do |t|
    t.integer  "user_id"
    t.string   "comment"
    t.integer  "material_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "documents", ["user_id"], name: "index_documents_on_user_id"

  create_table "groups", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "presentations", force: true do |t|
    t.integer  "document_id"
    t.integer  "user_id"
    t.string   "comment"
    t.text     "groups"
    t.integer  "last_open_slide"
    t.boolean  "auto_open"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "presentations", ["document_id"], name: "index_presentations_on_document_id"
  add_index "presentations", ["user_id"], name: "index_presentations_on_user_id"

  create_table "questions", force: true do |t|
    t.text     "name"
    t.integer  "answer_type"
    t.text     "answer_array"
    t.integer  "position"
    t.integer  "presentation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questions", ["presentation_id"], name: "index_questions_on_presentation_id"

  create_table "sections", force: true do |t|
    t.integer  "document_id"
    t.text     "source"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sections", ["document_id"], name: "index_sections_on_document_id"

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at"

  create_table "users", force: true do |t|
    t.string   "login"
    t.string   "fio"
    t.text     "groups"
    t.string   "roles"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
