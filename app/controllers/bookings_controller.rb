class BookingsController < ApplicationController

	before_action :authenticate_user!
	before_action :set_booking_params, except: [:index, :new, :edit, :delete, 
								:show, :user_bookings]

  skip_before_action :verify_authenticity_token

	def index
		if current_user.admin?
			@bookings = Booking.all
		else
			@bookings = current_user.bookings
		end		 
	end

	def new
		@booking = Booking.new
		@tourism_package = TourismPackage.find(params[:tourism_package_id])
	end

	def create
		@booking = Booking.create(@booking_params)

		if @booking.save
			redirect_to booking_path(@booking.id)
		else
			flash[:error] = 'Something went wrong'
			redirect_to root_path
		end
	end

	def edit
		@booking = Booking.find(params[:id])
		@tourism_package = @booking.tourism_package
	end

	def update
		@booking = Booking.find(params[:id])

		if (request.xhr?).is_a? Numeric
			@booking.update_attributes(params.require(:booking).permit(:status))
		elsif @booking.update_attributes(@booking_params)
			redirect_to booking_path(@booking.id)
		else
			flash[:error] = 'Something went wrong'
			redirect_to edit_booking_path(@booking.id)
		end
	end

	def show
		@booking = Booking.find(params[:id])
	end

	def delete
	end

	def user_bookings
		if current_user.admin?
			@bookings = Booking.all
		else
			@bookings = current_user.bookings
		end	
	end

	private

	def set_booking_params
	  params.require(:booking).permit(:user_id, :tourism_package_id,
			:amount_paid, :people_count, :passenger_details)

    booking_params = {}
    booking_params.merge!({user_id: params[:booking][:user_id]})
    booking_params.merge!({tourism_package_id: params[:booking][:tourism_package_id]})
		bookings_hash = params[:booking].to_unsafe_h.deep_symbolize_keys
		bookings_hash.slice!(:passenger_details)

		bookings_hash[:passenger_details][:other_passengers].delete(:name)
		bookings_hash[:passenger_details][:other_passengers].delete(:age)
		bookings_hash[:passenger_details][:other_passengers].delete(:gender)

		people_count = bookings_hash[:passenger_details][:master_passenger][:num_of_people]
		people_count = people_count.present? ? (people_count.to_i + 1) : 0 
		booking_params.merge!({passenger_details: bookings_hash[:passenger_details]})
		booking_params.merge!({people_count: people_count})
		@booking_params = booking_params
	end




end
