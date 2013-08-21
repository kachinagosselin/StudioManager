class User < ActiveRecord::Base
    rolify

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
            :recoverable, :rememberable, :trackable, :validatable
    
  has_many :accounts, :dependent => :destroy
  has_one :customer, :dependent => :destroy
  has_many :pictures, as: :imageable
  has_many :students, foreign_key: "event_id", dependent: :destroy
  has_many :events, through: :students

  # Setup accessible (or protected) attributes for your model
    attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :phone, :address, :city, :state, :description, :is_certified, :is_available
    
end
