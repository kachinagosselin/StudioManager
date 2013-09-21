class Credit < ActiveRecord::Base
    belongs_to :customer
    
    attr_accessible :studio_id, :customer_id, :quantity, :expires_at
    
end
