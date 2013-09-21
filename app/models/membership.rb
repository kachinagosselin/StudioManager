class Membership < ActiveRecord::Base
  belongs_to :studio
  has_many :purchases, foreign_key: "product_id"
  has_many :customers, :through => :purchase
    
    attr_accessible :studio_id, :name, :price, :interval, :interval_count, :trial_period_days, :title, :one_time_app, :prorate
    
    
    def title
        self.title = "#{self.name} - #{self.format_price}"
    end
    
    def format_price
        "$#{sprintf('%.2f', self.price/100.0)}"
    end
    
    def billing_frequency
        if self.interval_count > 1
            "#{self.interval_count} #{self.interval}s"
        else
            "#{self.interval_count} #{self.interval}"
        end
    end
    
    def trial_period
        if (self.trial_period_days != 0) && (self.trial_period_days.present?)
            return "#{self.trial_period_days} days"
        else
            return "none"
        end
    end
    
    def type
        if self.one_time_app == true
            return "one time"
        else
            return "recurring"
        end
    end
end
