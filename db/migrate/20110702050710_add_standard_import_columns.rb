class AddStandardImportColumns < ActiveRecord::Migration
  def self.up
    add_column :standards, :session_id, :string
    add_column :standards, :is_verified, :boolean
  end

  def self.down
    remove_column :standards, :session_id
    remove_column :standards, :is_verified
  end
end
