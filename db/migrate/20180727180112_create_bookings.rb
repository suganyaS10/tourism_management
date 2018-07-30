class CreateBookings < ActiveRecord::Migration[5.1]
  def up
    create_table :bookings do |t|
    	t.integer :user_id, null: false
    	t.integer :tourism_package_id, null: false
    	t.integer :people_count, null: false
    	t.integer :amount_paid, null: false, default: 0

      t.timestamps
    end
  end

  def down
  	drop_table :bookings
  end
end
