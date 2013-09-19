class Studio < ActiveRecord::Base
    acts_as_gmappable :check_process => false
    geocoded_by :gmaps4rails_address   
    after_validation :geocode          # auto-fetch coordinates
    
    belongs_to :user
    belongs_to :account
    
    has_many :events
    has_many :coupons
    has_many :charges
    has_many :memberships
    has_many :subscriptions
    has_many :purchases
    has_many :registered_events
    has_many :instructors
    has_many :students
    
    has_many :users, foreign_key: "user_id", :through => :registered_events
    has_many :staff, foreign_key: "user_id", :through => :instructors, :source => :user


    attr_accessible :address, :city, :state
    attr_accessible :location, :main_phone, :name, :website, :account_id, :cancellation_policy, :student_waiver, :instructor_waiver, :type
    
    def gmaps4rails_address
        "#{self.address} #{self.city}, #{self.state}" 
    end
    
    def add_student(user, signed)
        self.students.create!(user_id: user.id, signed_waiver: signed)
    end
end
