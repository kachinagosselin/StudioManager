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
  accepts_nested_attributes_for :profile
  has_many :registered_events

  # Setup accessible (or protected) attributes for your model
    attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :phone, :address, :city, :state, :description, :is_certified, :is_available, :profile, :profile_attributes
    
    def register!(event, studio)
        self.registered_events.create!(event_id: event.id, studio_id: studio.id)
    end
end
