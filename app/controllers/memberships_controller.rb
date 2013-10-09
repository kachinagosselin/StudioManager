class MembershipsController < ApplicationController
    
    def create
        @membership = Membership.new(params[:membership])

        respond_to do |format|
            if (@membership.save) && (current_user.customer.access_token.present?)
                @membership.create_plan(current_user)
                format.html { redirect_to products_path }
                format.js
            else
                format.html { redirect_to products_path, alert: 'Membership was unsuccessfully created.' }
                format.json { render json: @message.errors, status: :unprocessable_entity }
            end 
        end
    end

    def purchase
        @membership = Membership.find(params[:id])
        @profile = Profile.find(params[:profile_id])
        @customer = @profile.customer
        @client = @membership.client

        @purchase = Purchase.new(:customer_id => @profile.id, :product_type => "membership", :product_id => @membership.id,
            :discount_applied => false, :final_price => @membership.price)
        @membership.purchase(@client, @customer)

        respond_to do |format|
            if @purchase.save
                flash[:notice] = "Good"

                format.js
                format.html { render :action => "purchase", notice: 'Successful completed purchase.'  }

            else
                format.html { redirect_to root_path, alert: 'Membership was unsuccessfully created.' }
                format.json { render json: @message.errors, status: :unprocessable_entity }
            end 
        end
    end
        
    def destroy
        @client = current_user
        @membership = Memberships.find(params[:id])
        @stripe_membership = Stripe::Plan.retrieve({:id => @membership.name}, @client.customer.access_token)
        @stripe_membership.delete
        @membership.destroy
        redirect_to :back
    end
end
