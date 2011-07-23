class KioskController < ApplicationController
  include GeoKit::Geocoders
  def index
	@kiosks = Kiosk.all
	
	respond_to do |format| 
		format.html # => index.html.erb
		format.xml {render :xml => @kiosks}
	end 
  end

  def show
  end

  def new
	@kiosk = Kiosk.new		
  end

  def edit
	@kiosk = Kiosk.find(params[:id])  
  end

  def create
	@kiosk = Kiosk.new(@params[:kiosk])
	loc = MultiGeocoder(@kiosk.address)
	@kiosk.lat = loc.lat
	@kiosk.lng = loc.lng 
	
	respond_to do |format|
		if @kiosk.save 
			format.html {redirect_to @kiosk, :notice=>"Kiosk was successfully created" }
			format.xml { render :xml => @kiosk, :status => :created, :location => @kiosk}
		else 
			format.html { render :action => "new"}
			format.xml { render :xml => @kiosk.errors, :status => :unprocessable_entity }  
		end 
	end 
	
  end

  def update
	@kiosk = Kiosk.new(params[:id])
	name = "#{params[:kiosk][:street]}, #{params[:kiosk][:city]}, #{params[:kiosk][:state]}, #{params[:kiosk][:zipcode]}"
	loc = MultiGeocoder.new(name)
	params[:kiosk][:lat] = loc.lat
	params[:kiosk][:lng] = loc.lng

	respond_to do |format|	
		if @kiosk.update_attributes(params[:kiosk]) 
			format.html { redirect_to(@kiosk, :notice => "Kiosk was updated successfully") }
			format.xml { head :ok}
		else 
			format.html {render :action => "edit"} 
			format.xml {render :xml => @kiosk.errors, :status => :unprocessable_entity } 
		end
	end 
  end

  def destroy
  end
	
	def search 
		loc = IpGeocoder.geocode(request.remote_ip)
		@location = []
		@location << loc.street_address << loc.city << loc.country_code
	end 
end
