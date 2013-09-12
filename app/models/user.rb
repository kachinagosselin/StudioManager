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
    attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :phone, :address, :city, :state, :description, :is_certified, :is_available, :profile, :profile_attributes, :photo, :photo_attributes
    
    def register!(event, studio)
        self.registered_events.create!(event_id: event.id, studio_id: studio.id)
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
