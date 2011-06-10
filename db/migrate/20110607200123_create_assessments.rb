class CreateAssessments < ActiveRecord::Migration
  def self.up
    create_table :assessments do |t|
      t.string "name"
      t.integer "num_questions"

      t.timestamps
    end
  end

  def self.down
    drop_table :assessments
  end
end
