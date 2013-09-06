class Instructor < ActiveRecord::Base
    belongs_to :user
    belongs_to :studio
    
    attr_accessible :user_id, :studio_id

end
