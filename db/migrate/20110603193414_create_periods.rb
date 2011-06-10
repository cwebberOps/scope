class CreatePeriods < ActiveRecord::Migration
  def self.up
    create_table :periods do |t|
      t.integer "period_num"
      t.datetime "start_time"
      t.datetime "end_time"

      t.timestamps
    end
  end

  def self.down
    drop_table :periods
  end
end
