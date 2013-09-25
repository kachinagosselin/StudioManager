class ProductsController < ApplicationController
    
    def studio_index
        @studio = Studio.find(params[:id])
    end

    def professional_index
        @professional = current_user
    end
end
