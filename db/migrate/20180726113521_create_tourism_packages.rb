class CreateTourismPackages < ActiveRecord::Migration[5.1]
  def up
    create_table :tourism_packages do |t|
    	t.string :name, null: false
    	t.string :starting_point, null: false
    	t.string :end_point, null:false
    	t.datetime :start_date
    	t.datetime :end_date
    	t.text :intermediate_points
    	t.integer :min_age
    	t.integer :max_age
    	t.integer :max_people
    	t.integer :cost_per_person
    	t.datetime :last_date, null: false
    	t.integer :creator_id

      t.timestamps
    end
    
    add_index :tourism_packages, :name, unique: true
  end

  def down
  	drop_table :tourism_packages
  end
end
