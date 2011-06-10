class CreateStandards < ActiveRecord::Migration
  def self.up
    create_table :standards do |t|
      t.references :standard_subject

      t.string "designation"
      t.string "value"

      t.timestamps
    end

    add_index("standards","standard_subject_id")
  end

  def self.down
    drop_table :standards
  end
end
