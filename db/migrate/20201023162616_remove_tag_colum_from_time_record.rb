class RemoveTagColumFromTimeRecord < ActiveRecord::Migration[6.0]
  def change
    remove_column :time_records, :tag
  end
end
