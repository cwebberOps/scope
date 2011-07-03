class AddSubStandardImportColumns < ActiveRecord::Migration
  def self.up
    add_column :sub_standards, :session_id, :string
    add_column :sub_standards, :is_verified, :boolean
  end

  def self.down
    remove_column :sub_standards, :session_id
    remove_column :sub_standards, :is_verified
  end
end
