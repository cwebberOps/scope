class CreateSectionStudents < ActiveRecord::Migration
  def self.up
    create_table :section_students do |t|
      t.references :section
      t.references :student

      t.boolean "is_enrolled", :default => true

      t.timestamps
    end

    add_index("section_students","section_id")
    add_index("section_students","student_id")
  end

  def self.down
    drop_table :section_students
  end
end
