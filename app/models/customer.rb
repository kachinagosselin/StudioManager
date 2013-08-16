class Customer < ActiveRecord::Base
    belongs_to :user
  attr_accessible :studio_id, :user_id, :stripe_customer_token, :last_4_digits, :plan_id, :quantity, :trial_end_at, :email, :coupon_code, :description
end
