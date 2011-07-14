class GiveAssignmentsAName < ActiveRecord::Migration
  def self.up
    add_column :assessment_assignments, :name, :string
  end

  def self.down
    remove_column :assessment_assignments, :name
  end
end
