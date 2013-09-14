class User < ActiveRecord::Base
    rolify

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
            :recoverable, :rememberable, :trackable, :validatable
    
  has_one :account, :dependent => :destroy
  has_one :customer, :dependent => :destroy
  has_one :profile, :dependent => :destroy
  has_one :photo, :as => :imageable, :dependent => :destroy
    
    accepts_nested_attributes_for :photo
    accepts_nested_attributes_for :profile
    
  has_many :registered_events
  has_many :instructors
  has_many :purchases
  has_many :studios, foreign_key: "studio_id", :through => :instructors
  has_many :events, foreign_key: "event_id", :through => :registered_events

  # Setup accessible (or protected) attributes for your model
    attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :phone, :address, :city, :state, :description, :is_certified, :is_available, :profile, :profile_attributes, :photo, :photo_attributes, :stripe_code
    
    def save_with_stripe_account
        code = self.stripe_code
        params = ActiveSupport::JSON.decode(`curl -X POST https://connect.stripe.com/oauth/token -d client_secret=sk_test_I4Ci5lTRq3QtUQsejxMZBk71 -d code=#{self.stripe_code} -d grant_type=authorization_code`)
        self.customer.access_token = params['access_token']
        self.customer.refresh_token = params['refresh_token']
        self.customer.stripe_publishable_key = params['stripe_publishable_key']
        self.customer.stripe_user_id = params['stripe_user_id']
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
    
end
