class Student < ActiveRecord::Base
    attr_accessible :profile_id, :resource_type, :resource_id, :signed_waiver
    
    belongs_to :studio
    belongs_to :user
    has_many :profiles
    validates :profile_id, :resource_type, :resource_id, presence: true
end
