class AddIsEnrolledFieldToStudents < ActiveRecord::Migration
  def self.up
    add_column :students, :is_enrolled, :integer, :default => 1
  end

  def self.down
    remove_column :students, :is_enrolled
  end
  
end
