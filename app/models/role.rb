class Role < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :users_roles
  belongs_to :resource, :polymorphic => true
  
  scopify
    
    def description
        text = "" + self.name.capitalize
        if self.resource_type.present? && self.resource_type == "Studio"
            text = text + " of " + Studio.find(self.resource_id).name
        end
        return text
    end
end
