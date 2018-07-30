class AddPersonDetailsToBookings < ActiveRecord::Migration[5.1]
  def up
  	add_column :bookings, :passenger_details, :text
  end
end
