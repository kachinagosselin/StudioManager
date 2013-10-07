class RegisteredEvent < ActiveRecord::Base
    belongs_to :profile
    belongs_to :event
    belongs_to :studio
    
    attr_accessible :profile_id, :event_id, :studio_id, :attended, :canceled
end
