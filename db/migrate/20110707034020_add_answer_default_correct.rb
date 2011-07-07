class AddAnswerDefaultCorrect < ActiveRecord::Migration
  def self.up
    change_column :answers, :is_correct, :boolean, :default => 0
  end

  def self.down
  end
end
