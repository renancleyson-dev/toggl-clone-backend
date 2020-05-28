class AddLabelsToTimeRecord < ActiveRecord::Migration[5.2]
  def change
    add_column :time_records, :label, :string
    add_column :time_records, :tag, :string
  end
end
