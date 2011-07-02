class AddIsVerifiedToAssessments < ActiveRecord::Migration
  def self.up
    add_column :assessments, :is_verified, :boolean
  end

  def self.down
    remove_column :assessments, :is_verified
  end
end
