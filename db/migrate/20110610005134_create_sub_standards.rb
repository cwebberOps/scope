class CreateSubStandards < ActiveRecord::Migration
  def self.up
    create_table :sub_standards do |t|
      t.references :standard

      t.string "designation"
      t.text "value"

      t.timestamps

    end
      add_index :sub_standards, "standard_id"
  end

  def self.down
    drop_table :sub_standards
  end
end
