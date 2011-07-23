namespace :KioskLocator do 
	desc 'Update kiosk with longtitude and latitude information 
	task :add_kiosk_coordinates => :enviroment do 
		include GeoKit::Geocoders
		kiosks = Kiosk.all 
		begin 
			kiosks.each do |k|	
				loc = MultiGeocoder.code(k.address)
				k.lat = loc.lat 
				k.lng = loc.lng 
				k.update 
				puts "updated kiosk #{k.name} #{k.address} => [#{k.lat},#{k.lng}]"
			end
			rescue 
			puts $!
		end  
	end  

end 
