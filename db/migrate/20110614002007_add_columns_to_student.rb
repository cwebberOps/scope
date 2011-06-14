class AddColumnsToStudent < ActiveRecord::Migration
  def self.up
    add_column :students, :student_num, :integer
    add_column :students, :can_log_in, :boolean, :default => false
  end

  def self.down
    remove_column :students, :student_num
    remove_column :students, :can_log_in
  end
end
