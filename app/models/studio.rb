class Studio < ActiveRecord::Base
    acts_as_gmappable :check_process => false
    geocoded_by :gmaps4rails_address   
    after_validation :geocode          # auto-fetch coordinates
    
    belongs_to :account
    
    attr_accessible :address, :city, :state
    attr_accessible :location, :main_phone, :name, :website
    
    def gmaps4rails_address
        "#{self.address} #{self.city}, #{self.state}" 
    end
end
