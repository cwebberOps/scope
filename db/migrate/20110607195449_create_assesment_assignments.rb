class CreateAssesmentAssignments < ActiveRecord::Migration
  def self.up
    create_table :assesment_assignments do |t|
      t.references :assignment
      t.references :section

      t.datetime "date_start"
      t.datetime "date_end"
      t.string "password"
      t.boolean "can_review"

      t.timestamps
    end

    add_index("assesment_assignments", "assignment_id")
    add_index("assesment_assignments", "section_id")
  end

  def self.down
    drop_table :assesment_assignments
  end
end
