class MembershipsController < ApplicationController
        
        def index
            @memberships = Memberships.find(:all)

            respond_to do |format|
                format.html # index.html.erb
                format.json { render json: @memberships }
            end
        end
    
        def create
            @membership = Membership.new(params[:membership])

            respond_to do |format|
                if (@membership.save) && (current_user.customer.access_token.present?)
                    @membership.create_plan(current_user)
                    format.html { redirect_to :back }
                    format.json { head :no_content }
                    else
                    format.html { redirect_to :back, alert: 'Membership was unsuccessfully created.' }
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
