class ProductsController < ApplicationController
    
    def index
        @studio = Studio.find(params[:studio_id])
        @memberships = @studio.memberships.find(:all)
        @membership = @studio.memberships.new
        
        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @memberships }
        end
    end
end
