class TourismPackage < ApplicationRecord
  serialize :intermediate_points

	validates_presence_of :name, :start_date, :end_date, :last_date, 
												:starting_point, :end_point

  belongs_to :creator, class_name: 'User', foreign_key: :creator_id
  has_many :bookings

  before_save :validate_start_and_end_date,
  						 :validate_min_and_max_age



  def self.search(search_params)
    query_string = ''
    query_cond = []
    all_packages = TourismPackage.all
    search_params.symbolize_keys!

    if search_params[:starting_point].present?
      query_string += "starting_point= '#{search_params[:starting_point]}'"
    end

    if search_params[:end_point].present?
      query_string += " AND end_point= '#{search_params[:end_point]}'"
    end

    if search_params[:start_date].present?
      query_string += " AND start_date= '#{search_params[:start_date]}'"
    end

    @packages = TourismPackage.where("#{query_string}")
  end

  def remaining_seats
    seats_booked = self.bookings.sum(&:people_count)
    self.max_people - seats_booked
  end

  def has_free_seats?
    self.remaining_seats > 0
  end

  def validate_start_and_end_date
  	return false if self.start_date.blank? || self.end_date.blank?

  	if start_date < end_date
  		return true
  	else
  		return false
  	end
  end

  def validate_min_and_max_age
  	return false if self.min_age.blank? || self.max_age.blank?

  	if self.max_age < self.min_age
  		return false
  	else
  		return true
  	end
  end


end
