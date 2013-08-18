class Membership < ActiveRecord::Base
  belongs_to :studio
  attr_accessible :studio_id, :name, :amount, :interval, :interval_count, :trial_period_days
end
