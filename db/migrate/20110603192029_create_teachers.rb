class CreateTeachers < ActiveRecord::Migration
  def self.up
    create_table :teachers do |t|
      t.string "first_name", :limit => 50
      t.string "last_name", :limit => 50
      t.string "username", :limit => 50
      t.string "hashed_password", :limit => 100
      t.string "salt", :limit => 40
      t.string "email"
      t.boolean "is_admin"

      t.timestamps
    end
  end

  def self.down
    drop_table :teachers
  end
end
