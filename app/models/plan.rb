class Plan < ActiveRecord::Base
    has_many :accounts
    
    attr_accessible :name, :price, :limit

end
