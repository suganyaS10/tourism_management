namespace :seed do

  desc 'Import example Data'
  task packages: :environment do
  	name = 'package'
    start_date = Date.today + 15.days
    end_date = Date.today + 30.days
    start_point = ['Chennai', 'Mumbai', 'Rajasthan', 'Punjab', 'Bangalore']
    end_point = ['Pune', 'Goa', 'Mysore', 'Valparai','Haryana']
    intermediate_points = ['Pune', 'Chennai', 'Valparai', 'Punjab']
    min_age = 2
    max_age = 50
    max_people = 40
    cost_per_person = [12000, 40000, 2000, 3000]
    last_date = Date.today + 5.days
    
    sample_dob = Date.today - 25.years
    user = User.create!({:name => 'admin', :date_of_birth => sample_dob,
     :email => "admin123@gmail.com", :role_id => '1', :password => "admin123", :password_confirmation => "admin123" })


    (0..5).each do |i|
    	package = TourismPackage.create(name: "package-#{i}", start_date: start_date, end_date: end_date,
    		starting_point: "#{start_point.sample}", end_point: "#{end_point.sample}",
    		intermediate_points: "#{intermediate_points.sample}", min_age: min_age,
    		max_age: max_age, max_people: max_people, last_date: last_date, creator_id: user.id,
    		cost_per_person: "#{cost_per_person.sample}")
    	if package.save
    		Rails.logger.info "Package Created"
    		puts "s"
    	else
    		puts "error"
    		Rails.logger.info "#{package.errors}"
    	end
    end
  end
end