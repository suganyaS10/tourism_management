class Booking < ApplicationRecord
	serialize :passenger_details

	belongs_to :user
	belongs_to :tourism_package

	scope :approved, -> { where(status: 'Approved') }

	before_save :set_status

	def set_status
		if user.admin?
			self.status = 'Approved'
		else
			self.status = 'Pending'
		end
	end	

end
