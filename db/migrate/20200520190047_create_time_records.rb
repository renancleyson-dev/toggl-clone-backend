class CreateTimeRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :time_records do |t|

      t.timestamps
    end
  end
end
