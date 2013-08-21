class Membership < ActiveRecord::Base
  belongs_to :studio
  has_many :purchases, foreign_key: "product_id"
  has_many :customers, :through => :purchase
    
  attr_accessible :studio_id, :name, :price, :interval, :interval_count, :trial_period_days
end
