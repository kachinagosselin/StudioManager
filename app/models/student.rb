class Student < ActiveRecord::Base
    attr_accessible :studio_id, :user_id, :signed_waiver
    
    belongs_to :studio
    belongs_to :user
    validates :studio_id, presence: true
    validates :user_id, presence: true
end
