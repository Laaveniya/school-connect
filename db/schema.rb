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

ActiveRecord::Schema[7.0].define(version: 2023_07_14_061503) do
  create_table "adminships", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "school_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_adminships_on_school_id"
    t.index ["user_id"], name: "index_adminships_on_user_id"
  end

  create_table "course_batches", force: :cascade do |t|
    t.string "name"
    t.integer "max_enrollment_count"
    t.date "start_date"
    t.date "end_date"
    t.integer "course_id"
    t.integer "creator_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_batches_on_course_id"
    t.index ["creator_id"], name: "index_course_batches_on_creator_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.date "start_date"
    t.date "end_date"
    t.integer "status", default: 0, null: false
    t.integer "school_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "creator_id"
    t.index ["creator_id"], name: "index_courses_on_creator_id"
    t.index ["school_id"], name: "index_courses_on_school_id"
  end

  create_table "enrollments", force: :cascade do |t|
    t.integer "course_batch_id", null: false
    t.integer "student_id", null: false
    t.integer "approver_id"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["approver_id"], name: "index_enrollments_on_approver_id"
    t.index ["course_batch_id"], name: "index_enrollments_on_course_batch_id"
    t.index ["student_id"], name: "index_enrollments_on_student_id"
  end

  create_table "school_memberships", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "school_id", null: false
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_school_memberships_on_school_id"
    t.index ["user_id"], name: "index_school_memberships_on_user_id"
  end

  create_table "schools", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "creator_id"
    t.index ["creator_id"], name: "index_schools_on_creator_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer "role"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.integer "invited_by_id"
    t.integer "invitations_count", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "adminships", "schools"
  add_foreign_key "adminships", "users"
  add_foreign_key "course_batches", "users", column: "creator_id"
  add_foreign_key "courses", "schools"
  add_foreign_key "courses", "users", column: "creator_id"
  add_foreign_key "enrollments", "course_batches"
  add_foreign_key "enrollments", "users", column: "approver_id"
  add_foreign_key "enrollments", "users", column: "student_id"
  add_foreign_key "school_memberships", "schools"
  add_foreign_key "school_memberships", "users"
  add_foreign_key "schools", "users", column: "creator_id"
end
