class Purchase < ActiveRecord::Base
    belongs_to :customer
    belongs_to :studio
    
    attr_accessible :customer_id, :product_id, :product_type, :studio_id, :discount_applied
    
    validates_inclusion_of :product_type, :in => ["membership", "package"]

end
