class Package < ActiveRecord::Base
    belongs_to :studio
    
    attr_accessible :studio_id, :quantity, :percent_off, :name, :title, :price, :archived, :expires_at, :interval_count, :interval, :resource_type, :resource_id
    
    def title
            self.title = "#{self.name} - #{self.format_price}"
    end
    
    def total_price
        if !self.price.present?
            default = Studio.find(self.studio_id).default_event_price
            return default*self.quantity*(1-(self.percent_off/100.00))
        else
            self.price
        end
    end
    
    def format_price
        "$#{sprintf('%.2f', self.total_price/100.0)}"
    end

    def expiration
        if (self.expires_at.present?) && (!self.expires_at.nil?)
            return self.expires_at
        elsif (self.interval_count.present?) && (self.interval_count > 0)
            if self.interval_count > 1
                "#{self.interval_count} #{self.interval}s"
                else
                "#{self.interval_count} #{self.interval}"
            end
        else
            "unlimited"
        end
    end
end
