class Student < ActiveRecord::Base
    attr_accessible :profile_id, :resource_type, :resource_id, :signed_waiver
    
    belongs_to :studio
    belongs_to :user
    belongs_to :profile
    validates :profile_id, uniqueness: { scope: [:resource_type, :resource_id], message: "already a student" }
    validates :resource_type, :resource_id, presence: true

    def profile
    	Profile.find(self.profile_id)
    end

end
