class CreateKiosks < ActiveRecord::Migration
  def self.up
	create_table :kiosks do |t| 
		t.column :name, :string 
		t.column :street, :string 
		t.column :city, :string 
		t.column :state, :string 
		t.column :zipcode, :string 
		t.column :lng, :float 
		t.column :lat, :float
	end 
  end

  def self.down
	drop_table :kiosks
  end
end
