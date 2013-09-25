class Studio < ActiveRecord::Base
    resourcify
    
    acts_as_gmappable :check_process => false
    geocoded_by :gmaps4rails_address   
    after_validation :geocode          # auto-fetch coordinates
    
    belongs_to :user
    belongs_to :account
    
    has_many :locations
    has_many :events
    has_many :coupons
    has_many :memberships
    has_many :purchases
    has_many :packages
    has_many :registered_events
    
    has_many :users, foreign_key: "user_id", :through => :registered_events

    after_create :instantiate_first_location


    attr_accessible :address, :city, :state
    attr_accessible :location, :main_phone, :name, :website, :account_id, :cancellation_policy, :student_waiver, :instructor_waiver, :default_event_price
    
    def instantiate_first_location
        self.locations.create!(:address => address, :city => city, :state => state)
    end
    
    def gmaps4rails_address
        "#{self.address} #{self.city}, #{self.state}" 
    end
    
    def add_student(user, signed)
        if signed == true
            user.add_role :student, self
        end
    end
    
    def students
        Profile.with_role(:student, self)
    end
    
    def staff
        Profile.with_role(:instructor, self)
    end
    
    def save_customer!(client, options = {})
        if user.customer.present?
            stripe_customer = Stripe::Customer.create({description: user.email, card: user.customer.stripe_card_token, email: user.email}, client.customer.access_token)
            else
            stripe_customer = Stripe::Customer.create({description: user.email, card: stripe_card_token, email: user.email}, client.customer.access_token)
            if  !user.customer.present?
                customer = user.create_customer(:stripe_customer_token => stripe_customer.id, :email => user.email, :last_4_digits => last_4_digits)
            end
        end
        
      user.profile.become_student!(self)
   end
    
end
