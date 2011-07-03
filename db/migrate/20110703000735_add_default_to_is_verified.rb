class AddDefaultToIsVerified < ActiveRecord::Migration
  def self.up
    change_column :assessments, :is_verified, :boolean, :default => 1
    change_column :questions, :is_verified, :boolean, :default => 1
    change_column :standards, :is_verified, :boolean, :default => 1
    change_column :sub_standards, :is_verified, :boolean, :default => 1
  end

  def self.down
  end
end
