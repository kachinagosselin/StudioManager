class Location < ActiveRecord::Base
    acts_as_gmappable :check_process => false
    geocoded_by :gmaps4rails_address   
    after_validation :geocode          # auto-fetch coordinates

    belongs_to :studio
    
    attr_accessible :address, :city, :name, :state, :studio_id
    
    def gmaps4rails_address
        "#{self.address} #{self.city}, #{self.state}" 
    end
end
