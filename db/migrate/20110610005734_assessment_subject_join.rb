class AssessmentSubjectJoin < ActiveRecord::Migration
  def self.up
    create_table :assessments_subjects, :id => false do |t|
      t.integer "assessment_id"
      t.integer "subject_id"
    end
    add_index :assessments_subjects, ["assessment_id","subject_id"]
  end

  def self.down
    drop_table :assessments_subjects
  end
end
