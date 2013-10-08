class Profile < ActiveRecord::Base
    rolify
    
    acts_as_gmappable validation: false
    geocoded_by :gmaps4rails_address   
    search_methods :distance
    
    belongs_to :user
    has_one :photo, :as => :imageable, :dependent => :destroy
    has_many :availabilities, :dependent => :destroy
    has_many :registered_events
    has_many :registered, foreign_key: "event_id", :through => :registered_events, :source => :event

    accepts_nested_attributes_for :photo
    accepts_nested_attributes_for :availabilities

  # Setup accessible (or protected) attributes for your model
    attr_accessible :phone, :address, :city, :state, :description, :certification, :is_available, :is_not_available, :hide_map, :emergency_contact_name, :emergency_contact_number, :dob, :name, :email, :photo, :photo_attributes, :availabilities, :availability_attributes
    before_create :create_photo
    before_create :initialize_availability

    def create_photo
        self.build_photo
    end
    
    def initialize_availability
        (0..6).each do |n|
            self.availabilities.new(:day_of_week => n)
        end
    end
    
    def gmaps4rails_address
        "#{self.address}, #{self.city}, #{self.state}" 
    end
    
    def user
        if User.exists?(id: self.user_id)
        User.find(self.user_id)
        end
    end
    
    def location
        if self.state.present? && self.city.present?
            return "#{self.city}, #{self.state}" 
        elsif self.city.present?
            return "#{self.city}"
        elsif self.state.present?
            return "#{self.state}"
        else 
            return "none provided"
        end
    end
    
    # Return professional studios and students
    def studios
        Studio.with_role(:instructor, self)
    end
    
    def students
        Profile.with_role(:student, self)
    end
    
    # Student roles
    def become_student!(this, signed)
        if (signed == true) && (!self.has_role? :student, this)
        self.add_role :student, this
        end
    end

    def become_student!(this)
        if !self.has_role? :student, this
            self.add_role :student, this
        end
    end
    
    def remove_student(this)
        if (self.has_role? :student, this)
        self.remove_role :student, this
        end
    end
    
    # Instructor roles
    def become_instructor!(studio)
        if (!self.has_role? :instructor, studio)
        self.add_role :instructor, studio
        end
    end
    
    def remove_instructor(studio)
        if (self.has_role? :instructor, studio)
        self.remove_role :instructor, studio
        end
    end

    # Staff roles
    def become_staff!(studio)
        if (!self.has_role? :staff, studio)
            self.user.add_role :staff, studio
        end
    end
    
    def remove_staff(studio)
        if (self.has_role? :staff, studio)
            self.user.remove_role :staff, studio
        end
    end
    
    # Assigns role: instructor or student of professional or studio
    # Checks on each of the methods (above) prevents double assignment
    def assign_role(user_type, resource_type, resource_id)
        if user_type == "instructor"
            self.become_instructor!(Studio.find(resource_id))
        else user_type == "student"
            if resource_type == "Studio"
                self.become_student!(Studio.find(resource_id))
            elsif resource_type == "User"
                self.become_student!(User.find(resource_id))
            end
        end
    end
    
    # Returns available instructors for studio database
    def self.available_instructors
    #Profile.with_role(:instructor, :any)
        # When able to take in account availability use:
        Profile.with_role(:instructor, :any).where(:is_available => true)
    end
    

    def set_availability
        self.availabilities.each do |timeslot|
            if self.is_not_available == true
                self.update_attributes(:is_available => false)
            else
            if !timeslot.start_at.nil?
                self.update_attributes(:is_available => true)
            else
                self.update_attributes(:is_available => false)
            end
            end
        end
    end
        
    def dow_available?
        available = ""
        self.availabilities.each do |timeslot|
                available = available + ", " + timeslot.week_day
        end
        return available
    end

    def self.find_registered(event)
        @profiles = []
        @registered = RegisteredEvent.where(:attended => false).where(:event_id => event.id)
        @registered.each do |r|
            @profiles << Profile.find(r.profile_id)
        end
    
        return @profiles
    end

    def find_registered
        @events = []
        @registered = self.registered_events.where(:attended => false)
        @registered.each do |r|
            @events << Event.find(r.event_id)
        end

        return @events
    end

    def find_attended
        @events = []
        @registered = self.registered_events.where(:attended => true)
        @registered.each do |r|
            @events << Event.find(r.event_id)
        end
        return @events
    end

    def find_canceled_by_student
        self.registered_events.where(:canceled_by_student => true)
    end

    def find_canceled
        self.registered_events.where(:canceled => true)
    end

    def remove_registration(event)
        RegisteredEvent.where(:event_id => event.id).where(:profile_id => self.id).first.destroy
    end

    # Required for creating reports 
    def teaching_events_this_week
        Event.where(:instructor_id => self.id).where('start_at < ?', Date.today+7).order(:start_at)
    end

    def student_cancel(event)
        registered = self.registered_events.where(:event_id => event.id).first
        registered.update_attributes(:canceled_by_student => true)
        registered.save
    end

    def canceled_by_student?(event)
        registered = self.registered_events.where(:event_id => event.id).first
        return registered.canceled_by_student
    end

    def register!(event, checkin)
        self.registered_events.create!(event_id: event.id, attended: checkin)
        self.assign_role("student", event.resource_type, event.resource_id)  
    end

    def attend!(event)
        registered = self.registered_events.where(:event_id => event.id).first
        registered.update_attributes(:attended => true)
    end

    def has_been_canceled?(event)
        if self.registered_events.where(:event_id => event.id).first.canceled
            return true
        elsif self.registered_events.where(:event_id => event.id).first.canceled_by_student
            return true
        else
            return false
        end
    end

# Set preferences
def toggle_map
    if (self.hide_map.nil?) || (self.hide_map == false)
        self.update_attributes(:hide_map => true)
        else
        self.update_attributes(:hide_map => false)
    end
end

end
