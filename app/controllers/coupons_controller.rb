class CouponsController < ApplicationController
    
    def new
        @studio = Studio.find(params[:studio_id])
        @coupon = Studio.coupon.new
        
    end
end
