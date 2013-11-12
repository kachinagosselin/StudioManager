class Service < ActiveRecord::Base
  belongs_to :user
  attr_accessible :duration, :name, :price, :resource_id, :resource_type, :start_at

  def format_price
       "$#{sprintf('%.2f', self.price/100.0)}"
  end
end
