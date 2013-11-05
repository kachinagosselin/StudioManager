class LocationsController < ApplicationController

    def index
    end
    
    def show
    end
    
    def new
    end
    
    def create
    end
    
    def edit
    end
    
    def update
    end
    
    def destroy
        @location = Location.find(params[:id])
        @location.destroy
        redirect_to :back
    end
end
