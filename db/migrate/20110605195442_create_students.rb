class CreateStudents < ActiveRecord::Migration
  def self.up
    create_table :students do |t|
      t.string "last_name", :limit => 50
      t.string "first_name", :limit => 50
      t.integer "grad_year"
      t.string "password", :limit => 50

      t.timestamps
    end
  end

  def self.down
    drop_table :students
  end
end
