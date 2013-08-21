class Purchase < ActiveRecord::Base
    belongs_to :customer
    belongs_to :membership
    belongs_to :charge
    
    attr_accessible :customer_id, :product_id, :product_type
end
