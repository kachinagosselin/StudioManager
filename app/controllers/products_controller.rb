class ProductsController < ApplicationController
    
    def index
        if current_user.active_role.name == "owner" || current_user.active_role.name == "staff"
            @studio = Studio.find(current_user.active_role.resource_id)
        elsif current_user.active_role.name == "professional"
            @professional = current_user
        end
    end

end
