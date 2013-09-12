class Account < ActiveRecord::Base
    belongs_to :user
    belongs_to :plan
    
    has_one :studio
    
    validates_presence_of :plan_id
    validates_presence_of :user_id

    attr_accessible :plan_id, :studio_id, :user_id, :stripe_customer_token, :email, :is_active
    attr_accessor :stripe_card_token

end
