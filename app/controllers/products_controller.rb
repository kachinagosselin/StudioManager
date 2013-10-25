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
    
        @client = @resource.user
        @user = User.create(:name => params[:name], :email => params[:email], 
            :password => params[:password], :password_confirmation => params[:password_confirmation])

        if @user.save 
            @student = Student.create!(:profile_id => @user.profile.id, :resource_id => params[:resource_id], :resource_type => params[:resource_type], :signed_waiver => params[:signed_waiver])
            if params[:memberships].present?
            @product = Membership.find(params[:memberships])
            elsif params[:packages].present?
            @product = Package.find(params[:packages])
            end

            if params.has_key?(:save_card)
                @user.save_as_customer!(current_user, :stripe_card_token => params[:stripe_card_token], :last_4_digits => params[:last_4_digits])
                
                if @product.class.name == "Package"
                @stripe_charge = Stripe::Charge.create({
                                               :amount => @product.price,
                                               :currency => "usd",
                                               :customer => @user.customer.stripe_customer_token,
                                               :description => "Charge to test purchase of class"
                                               }, @client.customer.access_token
                                                 )
                end
            else
                @user.save_as_customer!(current_user, :last_4_digits => params[:last_4_digits])
                
                if @product.class.name == "Package"
                @stripe_charge = Stripe::Charge.create({
                                               :amount => @product.price,
                                               :currency => "usd",
                                               :card => params[:stripe_card_token],
                                               :description => "Charge to test purchase of class"
                                               }, @client.customer.access_token
                                                 )
                end
            end

            if @product.class.name == "Membership"
                @user.add_membership(@client, @product)
            end
            
            @purchase = Purchase.create!(:customer_id => @user.profile.id, :product_id => @product.id, :product_type => @product.class.name.downcase, :final_price => @product.price, :discount_applied =>false)
            redirect_to :back
        end
    end
end
