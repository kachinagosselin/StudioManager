class ProductsController < ApplicationController
    
    def index
        @studio = current_user.account.studio
        
        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @memberships }
        end
    end
end
