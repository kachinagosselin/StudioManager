class Profile < ActiveRecord::Base
    rolify
    
    acts_as_gmappable validation: false
    geocoded_by :gmaps4rails_address   
    search_methods :distance
    
    belongs_to :user
    has_one :photo, :as => :imageable, :dependent => :destroy
    has_many :availabilities, :dependent => :destroy
    
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
    
    # Return instructor studios
    def studios
        Studio.with_role(:instructor, self)
    end
    
    def students
        Profile.with_role(:student, self)
    end
    
    def become_student!(this)
        if (signed == true) && (!self.has_role? :student, this)
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
    
    # Assigns role: instructor or student of professional or studio
    # Checks on each of the methods (above) prevents double assignment
    def assign_role(user_type, account_type, client)
    if user_type == "instructor"
        self.become_instructor!(client.account.studio)
    else user_type == "student"
        if account_type == "studio"
            self.become_student!(client.account.studio)
        elsif account_type == "professional"
            self.become_student!(client)
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
