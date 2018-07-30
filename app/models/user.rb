class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :role
  has_many :bookings
  
  def admin?
  	self.try(:role).try(:id) == Role.find_by_name('admin').id
  end       
end
