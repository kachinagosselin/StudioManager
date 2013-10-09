class Purchase < ActiveRecord::Base
    belongs_to :profile
    belongs_to :studio
    
    attr_accessible :customer_id, :product_id, :product_type, :studio_id, :discount_applied, :resource_type, :resource_id, :final_price
    
    validates_inclusion_of :product_type, :in => ["membership", "package"]

end
