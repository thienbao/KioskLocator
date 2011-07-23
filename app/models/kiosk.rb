class Kiosk < ActiveRecord::Base
	acts_as_mappable
	def address 
		"#{self.street}, #{self.city}, #{self.state}, #{self.zipcode}"	 
	end 
end
