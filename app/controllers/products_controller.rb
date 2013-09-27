class ProductsController < ApplicationController
    
    def studio_index
        if params[:id].present?
        @studio = Studio.find(params[:id])
        end
    end

    def professional_index
        @professional = current_user
    end
end
