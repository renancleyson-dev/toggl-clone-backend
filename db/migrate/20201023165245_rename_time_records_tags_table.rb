class RenameTimeRecordsTagsTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :time_records_tags

    create_table :tags_time_records do |t|
      t.belongs_to :time_record
      t.belongs_to :tag
    end
  end
end
