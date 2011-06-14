class CreateSectionLevels < ActiveRecord::Migration
  def self.up
    create_table :section_levels do |t|
      t.string :name
      t.timestamps
    end

    add_column :sections, :section_level_id, :integer
  end

  def self.down
    drop_table :section_levels
    remove_column :sections, :section_level_id
  end
end
