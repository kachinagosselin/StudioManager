class ProductsController < ApplicationController
    
    def index
        @resource = current_user.active_role.resource
        @memberships = @resource.memberships
        @packages = @resource.packages    
    end

    def show

    end

    def _purchase
    end

end
