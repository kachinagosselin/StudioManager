class Profile < ActiveRecord::Base
    rolify
    
    acts_as_gmappable :check_process => false
    geocoded_by :gmaps4rails_address   
    after_validation :geocode          # auto-fetch coordinates
    search_methods :distance
    
    belongs_to :user
    has_one :photo, :as => :imageable, :dependent => :destroy
    accepts_nested_attributes_for :photo

  # Setup accessible (or protected) attributes for your model
    attr_accessible :phone, :address, :city, :state, :description, :is_certified, :is_available, :hide_map, :emergency_contact_name, :emergency_contact_number, :dob, :name, :email, :photo, :photo_attributes
    before_create :create_photo
    
    def create_photo
        self.build_photo
    end
    
    def gmaps4rails_address
        "#{self.address}, #{self.city}, #{self.state}" 
    end
    
    # Return instructor studios
    def studios
        Studio.with_role(:instructor, self)
    end
    
    def students
        Profile.with_role(:student, self)
    end
    
    def become_student!(this)
        self.add_role :student, this
    end
    
    # Instructor roles
    def become_instructor!(studio)
        self.add_role :instructor, studio
    end
    
    def remove_instructor(studio)
        self.remove_role :instructor, studio
    end
    
end
