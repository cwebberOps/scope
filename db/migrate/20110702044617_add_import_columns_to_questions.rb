class AddImportColumnsToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :session_id, :string
    add_column :questions, :is_verified, :boolean
  end

  def self.down
    remove_column :questions, :session_id
    remove_column :questions, :is_verified
  end
end
