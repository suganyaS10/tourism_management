class Role < ApplicationRecord

	validates_presence_of :name

	has_many :users

	ADMIN = 'admin'
	CUSTOMER = 'customer'

	ROLES_ARRAY = ["#{ADMIN}", "#{CUSTOMER}"]
end
