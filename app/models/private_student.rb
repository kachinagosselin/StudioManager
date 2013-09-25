class PrivateStudent < ActiveRecord::Base
    attr_accessible :professional_id, :user_id, :signed_waiver
    
    belongs_to :user
    validates :professional_id, presence: true
    validates :user_id, presence: true
end
