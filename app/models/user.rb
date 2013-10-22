class User < ActiveRecord::Base
    rolify
    
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
            :recoverable, :rememberable, :trackable, :validatable
    
  has_one :account
  has_one :profile
    
  has_many :teaching_events, foreign_key: "instructor_id", :through => :events, :source => :event

  accepts_nested_attributes_for :profile

  # Setup accessible (or protected) attributes for your model
    attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :phone, :address, :city, :state, :description, :is_certified, :is_available, :profile, :profile_attributes, :stripe_code, :active_role_id
    
    before_create :instantiate_profile
    after_create :initialize_role

    validates :name, :email, :presence => true
    validates :email, :uniqueness => true
    validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+.)+[a-z]{2,})$/i

    scope :student_of, lambda{|resource_ids| joins(:student).where(:resource_id => {:id => resource_ids}) unless resource_ids.nil?}

    # Required to create complete profile for user
    def instantiate_profile
        @profile = Profile.where(:email => email).first
        if @profile.present?
            self.profile = @profile
            self.profile.update_attributes(:name => name)
        else
            self.create_profile(:name => name, :email => email)
        end
    end

    def initialize_role     # Default role: student
        self.add_role :student
        role = self.roles.first
        self.update_attributes(:active_role_id => role.id)
    end

    # Managing roles for user: owner, staff, professional, student
    def active_role
        Role.find(self.active_role_id)
    end
    
    def account_roles # For display in navigation
        self.roles.order("name ASC")
    end
    
    def assign_role(role, this) # User for: owner, staff, professional, student
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
    
    # Retrieve objects assigned to user profile:
    #   many of these need to exist in the case of a user not having an account with our software
    def customer 
        self.profile.customer
    end

    def studio
        self.account.studio
    end

    def registered
        self.profile.find_registered
    end

    ### PROFESSIONAL METHODS ###
    def add_student(profile, signed)
        if signed == true
            # create Student object with resource type and resource id
            Student.create!(:resource_type => "User", :resource_id => self.id, :profile_id => profile.id)
            profile.add_role(student, self)
        end
    end

    def students 
        Profile.joins(:students).where(["students.resource_id = ? AND students.resource_type = ?", self.id, "User"])
    end
    # Required to save customer associated with user
    def save_with_stripe_account(stripe_code) 
        if !self.profile.customer.present?
            plan_id = 1 # Automatically assigns to free plan
            stripe_customer = Stripe::Customer.create(description: "Create account through Stripe Connect", plan: plan_id, email: self.email)
            customer = self.profile.build_customer(:stripe_customer_token => stripe_customer.id, :email => self.email, :plan_id => plan_id, :quantity => 1)
            customer.save
        end
        
        customer = self.profile.customer
        params = ActiveSupport::JSON.decode(`curl -X POST https://connect.stripe.com/oauth/token -d client_secret=sk_test_I4Ci5lTRq3QtUQsejxMZBk71 -d code=#{stripe_code} -d grant_type=authorization_code`)
        customer.access_token = params['access_token']
        customer.refresh_token = params['refresh_token']
        customer.stripe_publishable_key = params['stripe_publishable_key']
        customer.stripe_user_id = params['stripe_user_id']
        customer.save
        
        if !self.account.present?
            self.create_account(:plan_id => plan_id, :user_id => self.id, :email => self.email)
        end
    end
    
    # Methods required to mark user as attended 
    def attends(event)
        self.registered_events.find(:event_id => event.id).update_attributes(:attended => true)
    end
    
    # Required for creating reports 
    def teaching_events_this_week
        return Event.where(:instructor => self.name).where('start_at < ?', Date.today+7).order(:start_at)
    end
    
    def events_attended_this_week
        return RegisteredEvent.where(:user_id => self.name).where(:attended => true).where('start_at < ?', Date.today+7).order(:start_at)
    end
    
    # Required for tracking user history
    def events_attended(day)
        events = RegisteredEvent.where(:user_id => self.name).where(:attended => true).where('start_at = ?', day)
        return events.count
    end

    # Required for recording professional objects
    def events
        Event.where(:resource_type => "User").where(:resource_id => self.profile.id)
    end
    
    def memberships
        Membership.where(:resource_type => "User").where(:resource_id => self.profile.id)
    end
    
    def packages
        Package.where(:resource_type => "User").where(:resource_id => self.profile.id)
    end
    
    def coupons
        Coupon.where(:resource_type => "User").where(:resource_id => self.profile.id)
    end
    
    #
    def is_certified?
        self.profile.certification.present?
    end
    
    # Required to save customer of studio and/or indepedent professional
    # options = {stripe_card_token, last_4_digits, studio, instructor}
    def save_as_customer!(client, options = {})
        if self.customer.present? && self.customer.stripe_customer_token.present?
            stripe_customer = Stripe::Customer.create({description: "Customer of #{client.account.studio.name}: saved card information", card: self.customer.stripe_card_token, email: self.email}, client.customer.access_token)
        elsif options[:last_4_digits].present?
            stripe_customer = Stripe::Customer.create({description: "Customer of #{client.account.studio.name}: did not save card information - last 4 digits are #{options[:last_4_digits]}", card: stripe_card_token, email: self.email}, client.customer.access_token)
            customer = self.build_customer(:stripe_customer_token => stripe_customer.id, :email => self.email)
            customer.save
        else
            stripe_customer = Stripe::Customer.create({description: "Customer of #{client.account.studio.name}: card information not available", email: self.email}, client.customer.access_token)
            customer = self.build_customer(:stripe_customer_token => stripe_customer.id, :email => self.email)
            customer.save
        end
    end
    
    def add_credits(client, package)
        stripe_customer = Stripe::Customer.retrieve({:id => self.customer.stripe_customer_token}, client.customer.access_token)
        Stripe::Charge.create({:amount => package.price,
                                                :currency => "usd",
                                                :customer => stripe_customer.id,
                                                :description => "Charge for #{package.name}"}, client.customer.access_token)
        if (self.expires_at.present?) && (self.expires_at != null) 
            self.customer.credits.create!(:quantity => package.quantity, :expires_at => package.expires_at)
        elsif (self.interval_count.present?) && (self.interval_count > 0)
            if self.interval == "day"
                self.customer.credits.create!(:quantity => package.quantity, :expires_at => DateTime.now + package.interval_count.day)
            elsif self.interval == "week"
                self.customer.credits.create!(:quantity => package.quantity, :expires_at => DateTime.now + package.interval_count.week)
            elsif self.interval == "month"
                self.customer.credits.create!(:quantity => package.quantity, :expires_at => DateTime.now + package.interval_count.month)
            elsif self.interval == "year"
                self.customer.credits.create!(:quantity => package.quantity, :expires_at => DateTime.now + package.interval_count.year)
            end
        else
            self.customer.credits.create!(:quantity => package.quantity)
        end
    end
    
    def add_membership(client, membership)
        stripe_customer = Stripe::Customer.retrieve({:id => self.customer.stripe_customer_token}, client.customer.access_token)
        stripe_customer.update_subscription(:plan => membership.name, :prorate => membership.prorate)
        if membership.one_time_app == true
            stripe_customer.cancel_subscription(:at_period_end => true)
        end
    end
    
    def purchase!(studio, product, type, discount)
        self.customer.purchases.create(:product_id => product.id, :studio_id => studio.id, :product_type => type, :discount_applied => discount)
        self.register!(event, studio, true)
        if type=="package"
            spend_credit(studio)
        end
    end
    
    def spend_credit(studio)
        credit = self.customer.credits.where(:studio_id => studio.id).first
        credit.quantity = credit.quantity - 1
        if credit.quantity == 0
            credit.destroy
        else
            credit.save
        end
    end
    
    def paid_for_class?(studio)
        if self.customer.credits(studio).present?
            return true
        else
            return false
        end 
    end

    ## For history page
    def active_memberships
        active = []
        memberships = self.profile.find_purchased(Membership)
        memberships.each do |membership|
            client = membership.client
            stripe_customer = Stripe::Customer.retrieve({:id => self.customer.stripe_customer_token}, client.customer.access_token)
            status = stripe_customer.subscription.status
            if status == "active"
            active << membership
            end
        end
    
        return active
    end
    
    def credits(studio)
        self.credits.customer.credits.where(:studio_id => studio.id)
    end
    
    def change_active_role_to(role)
        self.update_attributes(:active_role_id => role.id)
    end

    def subscription_details(client)
        return Stripe::Customer.retrieve({:id => self.customer.stripe_customer_token}, client.customer.access_token)
    end

end
