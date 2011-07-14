class AddIsVisibleToAssessmentAssignments < ActiveRecord::Migration
  def self.up
    rename_table :assesment_assignments, :assessment_assignments
    add_column :assessment_assignments, :is_visible, :boolean, :default => true
  end

  def self.down
    remove_column :assessment_assignments, :is_visible
    rename_table :asesment_assignments, :assesment_assignments
  end
end
