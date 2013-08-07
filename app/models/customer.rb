class Customer < ActiveRecord::Base
    belongs_to :user     
    
    attr_accessible :stripe_customer_token
end
