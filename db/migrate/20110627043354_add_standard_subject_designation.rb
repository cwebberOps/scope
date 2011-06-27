class AddStandardSubjectDesignation < ActiveRecord::Migration
  def self.up
  
     add_column :standard_subjects, :designation, :string
  
  end

  def self.down
    
    remove_column :standard_subjects, :designation
    
  end
end
