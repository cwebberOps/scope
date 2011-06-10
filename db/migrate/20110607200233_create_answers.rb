class CreateAnswers < ActiveRecord::Migration
  def self.up
    create_table :answers do |t|
      t.references :question

      t.string "value"
      t.boolean "is_correct"

      t.timestamps
    end
    add_index("answers","question_id")
  end

  def self.down
    drop_table :answers
  end
end
