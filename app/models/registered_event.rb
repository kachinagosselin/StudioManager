class RegisteredEvent < ActiveRecord::Base
    belongs_to :user
    belongs_to :event
    belongs_to :studio
    
    attr_accessible :user_id, :event_id, :studio_id, :attended, :canceled
end
