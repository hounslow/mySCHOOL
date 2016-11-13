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

ActiveRecord::Schema.define(version: 6) do

  create_table "enrollments", primary_key: ["section_id", "student_id"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "section_id", null: false
    t.integer "student_id", null: false
    t.index ["student_id"], name: "student_id", using: :btree
  end

  create_table "instructors", primary_key: "instructor_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "instructor_name",  limit: 30
    t.string  "instructor_email", limit: 30
    t.boolean "is_professor"
  end

  create_table "office_hours", primary_key: ["start", "end", "day", "instructor_id"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.time    "start",                   null: false
    t.time    "end",                     null: false
    t.integer "day",           limit: 1, null: false
    t.integer "instructor_id",           null: false
    t.index ["instructor_id"], name: "instructor_id", using: :btree
  end

  create_table "project_grades", primary_key: ["project_name", "student_id", "section_id"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "project_name",  limit: 30, null: false
    t.integer "student_id",               null: false
    t.integer "section_id",               null: false
    t.integer "grade"
    t.integer "instructor_id"
    t.index ["instructor_id"], name: "instructor_id", using: :btree
    t.index ["section_id"], name: "section_id", using: :btree
    t.index ["student_id"], name: "student_id", using: :btree
  end

  create_table "section_teaches", primary_key: "section_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "section_name",  limit: 30
    t.integer "instructor_id",            null: false
    t.index ["instructor_id"], name: "instructor_id", using: :btree
  end

  create_table "students", primary_key: "student_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "student_name",  limit: 30
    t.string "student_email", limit: 30
  end

  add_foreign_key "enrollments", "section_teaches", column: "section_id", primary_key: "section_id", name: "enrollments_ibfk_1", on_delete: :cascade
  add_foreign_key "enrollments", "students", primary_key: "student_id", name: "enrollments_ibfk_2", on_delete: :cascade
  add_foreign_key "office_hours", "instructors", primary_key: "instructor_id", name: "office_hours_ibfk_1", on_delete: :cascade
  add_foreign_key "project_grades", "instructors", primary_key: "instructor_id", name: "project_grades_ibfk_3"
  add_foreign_key "project_grades", "section_teaches", column: "section_id", primary_key: "section_id", name: "project_grades_ibfk_2", on_delete: :cascade
  add_foreign_key "project_grades", "students", primary_key: "student_id", name: "project_grades_ibfk_1", on_delete: :cascade
  add_foreign_key "section_teaches", "instructors", primary_key: "instructor_id", name: "section_teaches_ibfk_1", on_delete: :cascade
end
