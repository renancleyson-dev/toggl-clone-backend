class CreateTags < ActiveRecord::Migration[6.0]
  def change
    create_table :tags do |t|
      t.string :name
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end

    create_table :time_records_tags do |t|
      t.belongs_to :time_record
      t.belongs_to :tag
    end
  end
end
