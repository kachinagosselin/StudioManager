class Customer < ActiveRecord::Base
    belongs_to :profile
    
    has_many :purchases
    has_many :charges
    has_many :credits
    
    attr_accessible :studio_id, :user_id, :stripe_customer_token, :last_4_digits, :plan_id, :quantity, :trial_end_at, :email, :coupon_code, :description, :access_token, :refresh_token, :stripe_publishable_key, :stripe_user_id, :resource_type, :resource_id
        
    def purchased?(product_type)
        purchases.find_by(product_type: product_type).present?
    end

    def packages
        purchases.find_by(product_type: product_type).present?
    end

    def memberships
        purchases.find_by(product_type: product_type).present?
    end
end
