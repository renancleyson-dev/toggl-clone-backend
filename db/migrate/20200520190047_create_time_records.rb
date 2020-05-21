class CreateTimeRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :time_records do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.belongs_to :user
      t.timestamps
    end
  end
end
