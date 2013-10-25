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

    def remote_purchase
        @resource = params[:resource_type].constantize.find(params[:resource_id])
        d
        @client = @resource.user
        @user = User.create(:name => params[:name], :email => params[:email], 
            :password => params[:password], :password_confirmation => params[:password_confirmation])

        if @user.save 
            @student = Student.create!(:profile_id => @user.profile.id, :resource_id => params[:resource_id], :resource_type => params[:resource_type], :signed_waiver => params[:signed_waiver])
            
        @stripe_charge = Stripe::Charge.create({
                                               :amount => 1600,
                                               :currency => "usd",
                                               :card => @user.customer.stripe_customer_token,
                                               :description => "Charge to test purchase of class"
                                               }, @client.customer.access_token
                                                 )
        @profile = @user.profile
        end
    end
end
