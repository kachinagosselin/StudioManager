class EventsController < ApplicationController
    
    def index
        @events = @studio.events
        
        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @events.as_json }
        end
    end
    
    def show
        @event = Event.find(params[:id])
        if @event.professional_id.present?
        @professional = User.find(@event.professional_id)
        else
        @studio = @event.studio
        end
    end

    def create
        @event = Event.create(params[:event])
        @user = User.where(:name => params[:event][:instructor]).first
        
        respond_to do |format|
            if @event.save
                format.html { redirect_to :back, notice: 'Event was successfully created.' }
                format.json { head :no_content }
                else
                format.html { redirect_to :back, alert: 'Event was unsuccessfully created.' }
                format.json { render json: @message.errors, status: :unprocessable_entity }
            end 
        end
    end
    
    def update
        @event = Event.find(params[:id])
        
        respond_to do |format|
            if @event.update_attributes(params[:event])
                format.html { redirect_to :back, notice: 'Event was successfully updated.' }
                format.json { head :no_content }
                else
                format.html { redirect_to :back }
                format.json { render json: @message.errors, status: :unprocessable_entity }
            end
        end
    end
    
    def purchase
        @studio = Studio.find(params[:studio_id])
        @event = Event.find(params[:id])
        @account = Account.find(@studio.account_id)
        @client = @account.user
        @user = current_user
        @stripe_charge = Stripe::Charge.create({
                                               :amount => 1600,
                                               :currency => "usd",
                                               :card => @user.customer.stripe_customer_token,
                                               :description => "Charge to test purchase of class"
                                               }, @client.customer.access_token
                                                 )
        @user.register!(@event, @studio, false)
        
    end

    # Notifies users that class has been canceled - refunds purchase. 
    # Refunding purchase means having credits restored if used. Or returning direct refund via Skype if it was a one time charge. May need a payment_type string to indicate how user has paid for class.
    def cancel
    end
    
    def archive
        
    end
    
    def destroy
        @event = Event.find(params[:id])
        if @event.users.present?
        @event.archive = true
        else
        @event.destroy
        end
        redirect_to :back
    end
end
