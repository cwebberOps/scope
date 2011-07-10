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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110707045905) do

  create_table "answers", :force => true do |t|
    t.integer  "question_id"
    t.string   "value"
    t.boolean  "is_correct",  :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answers", ["question_id"], :name => "index_answers_on_question_id"

  create_table "assesment_assignments", :force => true do |t|
    t.integer  "assignment_id"
    t.integer  "section_id"
    t.datetime "date_start"
    t.datetime "date_end"
    t.string   "password"
    t.boolean  "can_review"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assesment_assignments", ["assignment_id"], :name => "index_assesment_assignments_on_assignment_id"
  add_index "assesment_assignments", ["section_id"], :name => "index_assesment_assignments_on_section_id"

  create_table "assessments", :force => true do |t|
    t.string   "name"
    t.integer  "num_questions"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_verified",   :default => true
  end

  create_table "assessments_subjects", :id => false, :force => true do |t|
    t.integer "assessment_id"
    t.integer "subject_id"
  end

  add_index "assessments_subjects", ["assessment_id", "subject_id"], :name => "index_assessments_subjects_on_assessment_id_and_subject_id"

  create_table "periods", :force => true do |t|
    t.integer  "period_num"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", :force => true do |t|
    t.integer  "assessment_id"
    t.integer  "sub_standard_id"
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "session_id"
    t.boolean  "is_verified",        :default => true
  end

  add_index "questions", ["assessment_id"], :name => "index_questions_on_assessment_id"
  add_index "questions", ["sub_standard_id"], :name => "index_questions_on_sub_standard_id"

  create_table "responses", :force => true do |t|
    t.integer  "assessment_assignment_id"
    t.integer  "student_id"
    t.integer  "answer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "responses", ["answer_id"], :name => "index_responses_on_answer_id"
  add_index "responses", ["assessment_assignment_id"], :name => "index_responses_on_assessment_assignment_id"
  add_index "responses", ["student_id"], :name => "index_responses_on_student_id"

  create_table "section_levels", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "section_students", :force => true do |t|
    t.integer  "section_id"
    t.integer  "student_id"
    t.boolean  "is_enrolled", :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "section_students", ["section_id"], :name => "index_section_students_on_section_id"
  add_index "section_students", ["student_id"], :name => "index_section_students_on_student_id"

  create_table "sections", :force => true do |t|
    t.integer  "teacher_id"
    t.integer  "subject_id"
    t.integer  "term_id"
    t.integer  "section_type_id"
    t.integer  "period_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "section_level_id"
  end

  add_index "sections", ["period_id"], :name => "index_sections_on_period_id"
  add_index "sections", ["section_type_id"], :name => "index_sections_on_section_type_id"
  add_index "sections", ["subject_id"], :name => "index_sections_on_subject_id"
  add_index "sections", ["teacher_id"], :name => "index_sections_on_teacher_id"
  add_index "sections", ["term_id"], :name => "index_sections_on_term_id"

  create_table "standard_subjects", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "designation"
  end

  create_table "standards", :force => true do |t|
    t.integer  "standard_subject_id"
    t.string   "designation"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "session_id"
    t.boolean  "is_verified",         :default => true
  end

  add_index "standards", ["standard_subject_id"], :name => "index_standards_on_standard_subject_id"

  create_table "students", :force => true do |t|
    t.string   "last_name",   :limit => 50
    t.string   "first_name",  :limit => 50
    t.integer  "grad_year"
    t.string   "password",    :limit => 50
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "student_num"
    t.boolean  "can_log_in",                :default => false
  end

  create_table "sub_standards", :force => true do |t|
    t.integer  "standard_id"
    t.string   "designation"
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "session_id"
    t.boolean  "is_verified", :default => true
  end

  add_index "sub_standards", ["standard_id"], :name => "index_sub_standards_on_standard_id"

  create_table "subjects", :force => true do |t|
    t.integer  "standard_subject_id"
    t.string   "name",                :limit => 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subjects", ["standard_subject_id"], :name => "index_subjects_on_standard_subject_id"

  create_table "teachers", :force => true do |t|
    t.string   "first_name",      :limit => 50
    t.string   "last_name",       :limit => 50
    t.string   "username",        :limit => 50
    t.string   "hashed_password", :limit => 100
    t.string   "salt",            :limit => 40
    t.string   "email"
    t.boolean  "is_admin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "terms", :force => true do |t|
    t.string   "name",       :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
