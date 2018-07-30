namespace :upload do

  desc 'For the admins to pre fill From and To Locations'
  task from_to_with_intermediates: :environment do
  	locations_array = YAML.load_file('lib/tour_locations.yml')["locations"]

  end
end