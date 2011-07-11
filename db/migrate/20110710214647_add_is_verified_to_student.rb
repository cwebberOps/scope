class AddIsVerifiedToStudent < ActiveRecord::Migration
  def self.up
    add_column :students, :is_verified, :boolean, :default => 1
  end

  def self.down
    remove_column :students, :is_verified
  end
end
