class Coupon < ActiveRecord::Base
  attr_accessible :studio_id, :user_id, :duration, :amount_off, :duration_in_months, :max_redemptions, :percent_off, :redeem_by
end
