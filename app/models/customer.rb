class Customer < ActiveRecord::Base
    belongs_to :user
    has_many :purchases
    has_many :charges, :through => :purchase
    has_many :memberships, :through => :purchase
    
    attr_accessible :studio_id, :user_id, :stripe_customer_token, :last_4_digits, :plan_id, :quantity, :trial_end_at, :email, :coupon_code, :description, :access_token, :refresh_token, :stripe_publishable_key, :stripe_user_id
    
    
    def purchased?(product_type)
        purchases.find_by(product_type: product_type).first.present?
    end
    
    def purchase!(product, type)
        purchases.create!(product_id: product.id, product_type: type)
    end
end
