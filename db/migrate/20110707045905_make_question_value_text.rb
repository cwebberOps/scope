class MakeQuestionValueText < ActiveRecord::Migration
  def self.up
    change_column :questions, :value, :text
  end

  def self.down
    change_column :questions, :value, :string
  end
end
