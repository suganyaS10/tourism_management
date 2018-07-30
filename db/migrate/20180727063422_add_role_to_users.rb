class AddRoleToUsers < ActiveRecord::Migration[5.1]
  def up
  	add_column :users, :role_id, :integer, null: false
  end

  def down
  	remove_column :users, :role_id
  end
end
