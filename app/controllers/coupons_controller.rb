class CouponsController < ApplicationController
 
    def index
        if current_user.active_role.resource_type == "Studio"
            @studio = Studio.find(current_user.active_role.resource_id)
            @coupons = Coupon.where(:resource_type => "Studio").where(:resource_id => @studio.id)
        elsif current_user.active_role.resource_type == "User"
            @professional = current_user
            @coupons = Coupon.where(:resource_type => "User").where(:resource_id => @professional.id)
        end
        
        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @coupons }
        end
    end
    
    def create
        @coupon = Coupon.new(params[:coupon])
        @client = current_user
        @stripe_coupon = Stripe::Coupon.create({
                              :percent_off => params[:coupon][:percent_off],
                              :duration => 'repeating',
                              :duration_in_months => params[:coupon][:duration_in_months],
                              :id => params[:coupon][:title]}, @client.customer.access_token
                              )
        respond_to do |format|
            if @coupon.save
                format.html { redirect_to coupons_path }                
                format.json { head :no_content }
            else
                format.html { redirect_to coupons_path, alert: 'Coupon was unsuccessfully created.' }
                format.json { render json: @message.errors, status: :unprocessable_entity }
            end 
        end
    end
    
    def update
        @coupon = Coupon.find(params[:id])
        
        respond_to do |format|
            if @coupon.update_attributes(params[:coupon])
                format.html { redirect_to coupons_path }
                format.json { head :no_content }
                else
                format.html { redirect_to coupons_path, alert: 'Coupon was unsuccessfully updated.'   }
                format.json { render json: @message.errors, status: :unprocessable_entity }
            end
        end
    end
    
    def destroy
        @coupon = Coupon.find(params[:id])
        @coupon.destroy
        respond_to do |format|
            format.html { redirect_to coupons_path }
        end
    end
end
