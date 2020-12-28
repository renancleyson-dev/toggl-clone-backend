class RemoveUsernameAndFullNameFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :username
    remove_column :users, :full_name
  end
end
