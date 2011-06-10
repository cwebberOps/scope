class CreateResponses < ActiveRecord::Migration
  def self.up
    create_table :responses do |t|
      t.references :assessment_assignment
      t.references :student
      t.references :answer

      t.timestamps
    end
    add_index("responses","assessment_assignment_id")
    add_index("responses","student_id")
    add_index("responses","answer_id")
  end

  def self.down
    drop_table :responses
  end
end
