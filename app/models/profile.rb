class Profile < ActiveRecord::Base
    belongs_to :user

  # Setup accessible (or protected) attributes for your model
    attr_accessible :phone, :address, :city, :state, :description, :is_certified, :is_available, :hide_map
    
end
