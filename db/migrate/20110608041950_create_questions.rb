class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.references :assessment
      t.references :sub_standard
      
      t.string "value"

      t.timestamps
    end

    add_index("questions","assessment_id")
    add_index("questions","sub_standard_id")
  end

  def self.down
    drop_table :questions
  end
end
