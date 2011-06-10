class CreateStandardSubjects < ActiveRecord::Migration
  def self.up
    create_table :standard_subjects do |t|
      t.string "name"

      t.timestamps
    end
  end

  def self.down
    drop_table :standard_subjects
  end
end
