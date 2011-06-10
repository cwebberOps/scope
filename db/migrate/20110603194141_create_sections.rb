class CreateSections < ActiveRecord::Migration
  def self.up
    create_table :sections do |t|
      t.references :teacher
      t.references :subject
      t.references :term
      t.references :section_type
      t.references :period

      t.timestamps
    end

      add_index("sections", "teacher_id")
      add_index("sections", "subject_id")
      add_index("sections", "term_id")
      add_index("sections", "section_type_id")
      add_index("sections", "period_id")
  end

  def self.down
    drop_table :sections
  end
end
