class FixAssignmentColumnInAssessmentAssignment < ActiveRecord::Migration
  def self.up
    rename_column :assessment_assignments, :assignment_id, :assessment_id
  end

  def self.down
    rename_column :assessment_assignments, :assessment_id, :assignment_id
  end
end
