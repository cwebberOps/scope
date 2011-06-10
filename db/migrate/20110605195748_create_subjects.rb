class CreateSubjects < ActiveRecord::Migration
  def self.up
    create_table :subjects do |t|
      t.references :standard_subject

      t.string "name", :limit => 50

      t.timestamps
    end
    add_index("subjects","standard_subject_id")
  end

  def self.down
    drop_table :subjects
  end
end
