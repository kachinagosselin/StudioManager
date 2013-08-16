class Subscription < ActiveRecord::Base
  attr_accessible :studio_id, :user_id, :status, :stripe_customer_token, :cancel_at_period_end, :plan_id, :quantity, :started_at, :canceled_at, :current_period_end, :current_period_start, :ended_at, :trial_end_at, :trial_start_at
end
