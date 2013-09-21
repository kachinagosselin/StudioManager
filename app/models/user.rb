class User < ActiveRecord::Base
    rolify

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
            :recoverable, :rememberable, :trackable, :validatable
    
  has_one :account, :dependent => :destroy
  has_one :customer, :dependent => :destroy
  has_one :profile
  has_one :photo, :as => :imageable, :dependent => :destroy
    
    accepts_nested_attributes_for :photo
    accepts_nested_attributes_for :profile

  has_many :charges
  has_many :credits
  has_many :registered_events
  has_many :instructors
  has_many :purchases
  has_many :studios, foreign_key: "studio_id", :through => :instructors
  has_many :events, foreign_key: "event_id", :through => :registered_events

  # Setup accessible (or protected) attributes for your model
    attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :phone, :address, :city, :state, :description, :is_certified, :is_available, :profile, :profile_attributes, :photo, :photo_attributes, :stripe_code, :max_distance
    
    before_create :instantiate_profile
        
    def instantiate_profile
        self.create_profile(:name => name, :email => email)
        self.create_photo
    end
    
    def save_with_stripe_account
        code = self.stripe_code
        params = ActiveSupport::JSON.decode(`curl -X POST https://connect.stripe.com/oauth/token -d client_secret=sk_test_I4Ci5lTRq3QtUQsejxMZBk71 -d code=#{self.stripe_code} -d grant_type=authorization_code`)
        self.customer.access_token = params['access_token']
        self.customer.refresh_token = params['refresh_token']
        self.customer.stripe_publishable_key = params['stripe_publishable_key']
        self.customer.stripe_user_id = params['stripe_user_id']
        self.customer.save
    end
    
    def register!(event, studio, checkin)
        self.registered_events.create!(event_id: event.id, studio_id: studio.id, attended: checkin)
    end
    
    def is_registered?(event)
        self.registered_events.where(:event_id => event.id).first.present?
    end

    def attends(event)
        self.registered_events.where(:event_id => event.id).first.update_attributes(:attended => true)
    end
    
    def teaching_events_this_week
        return Event.where(:instructor => self.name).where('start_at < ?', Date.today+7).order(:start_at)
    end
    
    def events_attended_this_week
        return RegisteredEvent.where(:user_id => self.name).where(:attended => true).where('start_at < ?', Date.today+7).order(:start_at)
    end
    
    def events_attended(day)
        events = RegisteredEvent.where(:user_id => self.name).where(:attended => true).where('start_at = ?', day)
        return events.count
    end

    def teaching_events
        return Event.where(:instructor => self.name)
    end
    
    def instructor?(studio)
        if studio == "any"
            if self.studios.present?
                return true
            else 
                return false
            end
        else
            if self.studios.where(id: studio.id).present?
                return true
            else 
                return false
            end
        end
    end
    
    def become_instructor!(studio)
        self.instructors.create!(studio_id: studio.id)
    end
    
    def is_certified?
        self.profile.certification.present?
    end
    
    def save_customer_for_studio(client, studio, stripe_card_token, last_4_digits)
        stripe_customer = Stripe::Customer.create({description: self.email, card: stripe_card_token, email: self.email}, client.customer.access_token)
        if  !self.customer.present?
            customer = self.create_customer(:stripe_customer_token => stripe_customer.id, :email => self.email, :last_4_digits => last_4_digits)
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
        if type="package"
            spend_credit(studio)
        end
    end
    
    def spend_credit(studio)
        credit = self.customer.credits.where(:studio_id => studio.id, :order => "expires_at ASC").first
        credit.quantity = credit.quantity - 1
        if credit.quantity == 0
            credit.destroy
        else
            credit.save
        end
    end
    
    def paid_for_class?(studio)
        if self.active_membership(studio)
            return true
        elsif self.customer.credits(studio).present?
            self.spend_credit(studio)
            return true
        else
            return false
        end 
    end
        
    def active_membership(studio)
        client = User.find(studio.account.user_id)
        stripe_customer = Stripe::Customer.retrieve({:id => self.customer.stripe_customer_token}, client.customer.access_token)
        status = stripe_customer.status
        if status == "active"
            return true
        else
            return false
        end
    end
    
    def credits(studio)
        self.credits.customer.credits.where(:studio_id => studio.id)
    end
end
