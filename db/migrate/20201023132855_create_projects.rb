class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :color
      t.belongs_to :user
      t.timestamps
    end

    add_reference :time_records, :project
  end
end
