class MembershipsController < ApplicationController
        
        def index
            @studio = Studio.find(params[:studio_id])
            @memberships = @studio.memberships.find(:all)

            respond_to do |format|
                format.html # index.html.erb
                format.json { render json: @memberships }
            end
        end
    
        def new
        end
    
        def create
            @studio = Studio.find(params[:studio_id])
            @membership = @studio.memberships.new(params[:membership])
            @client = current_user
            @stripe_membership = Stripe::Plan.create({
                                                     :amount => params[:membership][:price],
                                                     :interval => params[:membership][:interval],
                                                     :name => params[:membership][:name],
                                                     :currency => 'usd',
                                                     :id => params[:membership][:name]
                                                     }, @client.customer.access_token
                                                   )
            respond_to do |format|
                if @membership.save
                    format.html { redirect_to studio_products_path(@studio) }
                    format.json { head :no_content }
                    else
                    format.html { redirect_to studio_products_path(@studio), alert: 'Membership was unsuccessfully created.' }
                    format.json { render json: @message.errors, status: :unprocessable_entity }
                end 
            end
        end
    

        
    def destroy
        @studio = Studio.find(params[:studio_id])
        @membership = @studio.memberships.find(params[:id])
        @client = current_user
        @stripe_membership = Stripe::Plan.retrieve({:id => @membership.name}, @client.customer.access_token)
        @stripe_membership.delete
        @membership.destroy
        redirect_to studio_products_path(@studio)
    end
end
