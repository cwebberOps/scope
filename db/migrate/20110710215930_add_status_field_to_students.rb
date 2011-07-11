class AddStatusFieldToStudents < ActiveRecord::Migration
  def self.up
    add_column :students, :import_status, :integer, :default => 0
  end

  def self.down
    remove_column :students, :import_status
  end
end
