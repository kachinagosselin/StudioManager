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
    
    def user
        if User.exists?(id: self.user_id)
        User.find(self.user_id)
        end
    end
    
    # Return instructor studios
    def studios
        Studio.with_role(:instructor, self)
    end
    
    def students
        Profile.with_role(:student, self)
    end
    
    def become_student!(this)
        if signed == true
        self.add_role :student, this
        end
    end

    def remove_student(this)
        self.remove_role :student, this
    end
    
    # Instructor roles
    def become_instructor!(studio)
        self.add_role :instructor, studio
    end
    
    def remove_instructor(studio)
        self.remove_role :instructor, studio
    end
    
    def assign_role(user_type, account_type)
    if user_type == "instructor"
        self.become_instructor!(current_user.account.studio)
    else user_type == "student"
        if account_type == "studio"
            self.become_student!(current_user.account.studio)
        elsif account_type == "professional"
            self.become_student!(current_user)
        end
    end
    end
    
    def test
    
    end 

    def self.find_registered(event)
    @registered = Profile.with_role(:registered, event).all
    @registered.each do |profile|
        if profile.has_role? :attended, event
        @registered.delete(profile)
        end
    end
    return @registered
    end

    def find_registered
        @registered = Event.with_role(:registered, self).all
    @registered.each do |event|
        if self.has_role? :attended, event
            @registered.delete(event)
        end
    end
    return @registered
    end

    def find_attended
        Event.with_role(:attended, self).all
    end

    # Required for creating reports 
    def teaching_events_this_week
        Event.where(:instructor => self.name).where('start_at < ?', Date.today+7).order(:start_at)
    end


    def canceled_by_student?(event)
        registered = self.registered_events.where(:event_id => event.id).first
        return registered.canceled_by_student
    end


end
