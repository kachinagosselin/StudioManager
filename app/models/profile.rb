class Profile < ActiveRecord::Base
    acts_as_gmappable :check_process => false
    geocoded_by :gmaps4rails_address   
    after_validation :geocode          # auto-fetch coordinates
    search_methods :distance
    
    belongs_to :user
    has_one :photo, :as => :imageable, :dependent => :destroy
    accepts_nested_attributes_for :photo

  # Setup accessible (or protected) attributes for your model
    attr_accessible :phone, :address, :city, :state, :description, :is_certified, :is_available, :hide_map, :emergency_contact_name, :emergency_contact_number, :dob, :name, :email, :photo, :photo_attributes

    
    def gmaps4rails_address
        "#{self.address}, #{self.city}, #{self.state}" 
    end
end
