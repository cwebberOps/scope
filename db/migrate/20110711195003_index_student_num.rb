class IndexStudentNum < ActiveRecord::Migration
  def self.up
    add_index("students","student_num", :unique => true)
  end

  def self.down
    remove_index("students","student_num")
  end
end
