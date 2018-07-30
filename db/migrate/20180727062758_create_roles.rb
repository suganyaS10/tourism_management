class CreateRoles < ActiveRecord::Migration[5.1]
  def up
    create_table :roles do |t|
    	t.string :name, null: false

      t.timestamps
    end

    Role::ROLES_ARRAY.each do |role|
    	role = Role.create(name: role)
    	role.save
    end
  end

  def down
  	drop_table :roles
  end
end
