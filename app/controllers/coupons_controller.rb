class CouponsController < ApplicationController
 
    def index
        @studio = Studio.find(params[:studio_id])
        @coupons = @studio.coupons.find(:all)
        @new_coupon = @studio.coupons.new
        
        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @coupons }
        end
    end
    
    def create
        @studio = Studio.find(params[:studio_id])
        @coupon = Coupon.create(params[:coupon])
        @coupon.studio_id = @studio.id
        
        respond_to do |format|
            if @coupon.save
                format.html { redirect_to studio_coupons_path(@studio), notice: 'Coupon was successfully created.' }
                format.json { head :no_content }
                else
                format.html { render :action => 'new', alert: 'Coupon was unsuccessfully created.' }
                format.json { render json: @message.errors, status: :unprocessable_entity }
            end 
        end
    end
    
    def destroy
        @coupon = Coupon.find(params[:id])
        @coupon.destroy
        redirect_to :back
    end
end
