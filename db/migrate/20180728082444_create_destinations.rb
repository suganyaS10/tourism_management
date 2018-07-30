class CreateDestinations < ActiveRecord::Migration[5.1]
  def change
    create_table :destinations do |t|
    	t.string :starting_point
    	t.string :end_point
    	t.text :intermediate_points

      t.timestamps
    end
  end
end
