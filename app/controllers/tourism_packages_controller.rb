class TourismPackagesController < ApplicationController

	# before_action :authenticate_user!
	before_action :set_tourism_package_params, except: [:index, :new, :search, :show,
		:search_packages, :edit, :destroy]

	skip_before_action :verify_authenticity_token, only: [:search_packages]	

	def index
		@packages = TourismPackage.all
	end

	def new
		locations_hash = YAML.load_file('lib/tour_locations.yml')["locations"]
		@start_points = locations_hash.pluck("start_point").uniq
		@end_points = locations_hash.pluck("end_point").uniq
		@intermediate_points = locations_hash.pluck("intermediate_points").uniq
		@package = TourismPackage.new
		 render layout: false
		 # render 'color-box'
	end

	def create
		@package = TourismPackage.create(@tourism_package_params)
		@package.creator = current_user

		if @package.save
			redirect_to tourism_packages_path
		else
			flash[:error] = @package.errors.messages
			redirect_to new_tourism_package_path
		end
	end

	def show
		@package = TourismPackage.find(params[:id])
	end

	def edit
		locations_hash = YAML.load_file('lib/tour_locations.yml')["locations"]
		@start_points = locations_hash.pluck("start_point").uniq
		@end_points = locations_hash.pluck("end_point").uniq
		@intermediate_points = locations_hash.pluck("intermediate_points").uniq
		@package = TourismPackage.find(params[:id])
		render layout: false
	end

	def update
		@package = TourismPackage.find(params[:id])

		if @package.update_attributes(@tourism_package_params)
			redirect_to tourism_packagess_path
		else
			redirect_to edit_tourism_package_path(@package)
		end
	end

	def destroy
		package = TourismPackage.find(params[:id])

		if package.bookings.present?
			flash[:error] = "You cannot delete a package with Bookings"
			redirect_to root_path
		else
			package.destroy
			redirect_to root_path
		end
	end

	def search_packages
		@packages = TourismPackage.search(JSON.parse(params[:anything]))
      
      # render layout: false
		  respond_to do |format|
        format.js       
      end
	end

	private

	def set_tourism_package_params
		@tourism_package_params = params.require(:tourism_package).permit(:name, :start_date, :end_date, :starting_point,
			:end_point, :min_age, :max_age, :max_people, :cost_per_person, 
			:intermediate_points, :creator_id, :last_date)
	end





end
