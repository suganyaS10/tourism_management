class ToursController < ApplicationController

	def home
		locations_hash = YAML.load_file('lib/tour_locations.yml')["locations"]
		@start_points = locations_hash.pluck("start_point").uniq
		@end_points = locations_hash.pluck("end_point").uniq
		@packages = TourismPackage.all
	end
end
