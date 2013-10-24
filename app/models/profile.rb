class Profile < ActiveRecord::Base
    rolify
    
    acts_as_gmappable validation: false
    geocoded_by :gmaps4rails_address   
    search_methods :distance
    
    belongs_to :user
    has_many :students

    has_one :photo, :as => :imageable, :dependent => :destroy
    has_one :customer, :dependent => :destroy

    has_many :availabilities, :dependent => :destroy
    has_many :registered_events
    has_many :registered, foreign_key: "event_id", :through => :registered_events, :source => :event
    has_many :purchases

    accepts_nested_attributes_for :photo
    accepts_nested_attributes_for :availabilities

  # Setup accessible (or protected) attributes for your model
    attr_accessible :phone, :address, :city, :state, :description, :certification, :is_available, :is_not_available, :hide_map, :emergency_contact_name, :emergency_contact_number, :dob, :name, :email, :photo, :photo_attributes, :availabilities, :availability_attributes
    before_create :initialize_photo, :initialize_availability

    scope :available, where(:is_available => 1)
    scope :sorted, order(:created_at => :desc)
    # Intialize upon create
    def initialize_photo
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
    
    # Determine if profile is associated with active user
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
    
    # Manage profile roles
    def assign_role(role, this) # User for: instructor or student of professional or studio
        if !self.has_role? role, this
            self.add_role role, this
        end
    end
    
    def unassign_role(role, this)
        self.remove_role role, this
    end

    def belongs_to_role?(role, this)
        return self.has_role? role, this
    end  
    
    def set_availability
        if self.is_not_available == true
                self.update_attributes(:is_available => false)
                return
        else
        self.availabilities.each do |timeslot|
            if !timeslot.start_at.nil?
                self.update_attributes(:is_available => true)
                return
            end
        end
        end
    end
        
    def display_availability
        available = ""
        self.availabilities.each do |timeslot|
                available = available + ", " + timeslot.week_day
        end
        return available
    end

    # Find all events by specific status: registered, attended, canceled, and canceled by student
    def find_registered
        registered = self.registered_events.where(:attended => false)
        return self.convert_to_events(registered)
    end

    def find_attended
        registered = self.registered_events.where(:attended => true)
        return self.convert_to_events(registered)
    end

    def find_canceled_by_student
        registered = self.registered_events.where(:canceled_by_student => true)
        return self.convert_to_events(registered)
    end

    def find_canceled
        events = []
        self.registered_events.each do |r|
            event = Event.find(r.event_id)
            if event.canceled
            events << event
            end
        end
        return events
    end

    def convert_to_events(registered)
        events = []
        registered.each do |r|
            events << Event.find(r.event_id)
        end
        return events
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
        self.assign_role("student", event.object)  
    end

    def attend!(event)
        registered = self.registered_events.where(:event_id => event.id).first
        registered.update_attributes(:attended => true)
    end

    def has_been_canceled?(event)
        if Event.find(event.id).canceled
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

# Find purchased memberships and packages
def find_purchased(object, resource)
    @products = []
    @purchases = Purchase.where(:customer_id => self.id).where(:product_type => object.to_s.downcase)
    @purchases.each do |r|
        product = object.find(r.product_id)
        if product.resource_id == resource.id && product.resource_type == resource.to_s.downcase
        @products << product
        end
    end
    return @products
end

def active_membership(resource)
    client = resource.user
        stripe_customer = Stripe::Customer.retrieve({:id => self.customer.stripe_customer_token}, client.customer.access_token)
        status = stripe_customer.subscription.status
        if status == "active"
            return true
        else
            return false
        end
    end

    def active_memberships(resource)
        active = []
        memberships = self.find_purchased(Membership, resource)
        memberships.each do |membership|
            client = membership.client
            stripe_customer = Stripe::Customer.retrieve({:id => self.customer.stripe_customer_token}, client.customer.access_token)
            status = stripe_customer.subscription.status
            if status == "active"
            active << membership
            end
        end
    end
    
    ### MODEL METHODS: across all profiles ###
    # Returns available instructors for studio database
    def self.available_instructors
        # When able to take in account availability use:
        Profile.with_role(:instructor, :any).where(:is_available => true)
    end

    def self.find_registered(event)
        @profiles = []
        @registered = RegisteredEvent.where(:attended => false).where(:event_id => event.id)
        @registered.each do |r|
            @profiles << Profile.find(r.profile_id)
        end
    
        return @profiles
    end

end
