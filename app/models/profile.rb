class Profile < ActiveRecord::Base
    belongs_to :user

  # Setup accessible (or protected) attributes for your model
    attr_accessible :phone, :address, :city, :state, :description, :is_certified, :is_available, :hide_map, :emergency_contact_name, :emergency_contact_number, :dob, :name, :email
    
end
