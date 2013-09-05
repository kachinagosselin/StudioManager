class CouponsController < ApplicationController
 
    def index
        @studio = Studio.find(params[:studio_id])
        @coupons = @studio.coupons.find(:all)
        
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
                format.html { redirect_to studio_coupons_path(@studio) }                
                format.json { head :no_content }
            else
                format.html { render :action => 'new', alert: 'Coupon was unsuccessfully created.' }
                format.json { render json: @message.errors, status: :unprocessable_entity }
            end 
        end
    end
    
    def edit
        @studio = Studio.find(params[:studio_id])
        @coupon = Coupon.find(params[:id])
    end
    
    
    def update
        @studio = Studio.find(params[:studio_id])
        @coupon = Coupon.find(params[:id])
        
        respond_to do |format|
            if @coupon.update_attributes(params[:event])
                format.html { redirect_to studio_coupons_path(@studio), notice: 'Coupon was successfully updated.' }
                format.json { head :no_content }
                else
                format.html { render action: "edit" }
                format.json { render json: @message.errors, status: :unprocessable_entity }
            end
        end
    end
    
    def destroy
        @coupon = Coupon.find(params[:id])
        @studio = Studio.find(@coupon.studio_id)
        @coupon.destroy
        respond_to do |format|
            format.html { redirect_to studio_coupons_path(@studio) }
        end
    end
end
