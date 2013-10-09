class CustomersController < ApplicationController
    
    def create 
        if(Rails.env.development? || Rails.env.staging?)
            Stripe.api_key
        else
            Stripe.api_key = ENV['STRIPE_API_KEY']
        end
        @user = Profile.find(params[:profile_id])        
        @stripe_customer = Stripe::Customer.create(description: @user.email, card: params[:stripe_card_token])
        @customer = @user.build_customer(:stripe_customer_token => @stripe_customer.id, :email => @user.email, :last_4_digits => params[:last_4_digits])
        respond_to do |format|
            if @customer.save
                format.html { redirect_to :back, notice: 'Card successfully added.' }
                format.json { head :no_content }
                else
                @user.customer.destroy
                format.html { redirect_to :back, alert: 'Card was unsuccessfully added.' }
                format.json { render json: @message.errors, status: :unprocessable_entity }
            end 
        end
    end
    
    def stripe_authorization
        @user = current_user
        @user.save_with_stripe_account(params[:code])
        if @user.save 
            redirect_to root_path, :notice => "Thank you for giving us access to your stripe account. Please add Studio details!"
            else
            redirect_to :back, :alert => "Failed to register your stripe account."
        end        
    end 
    
    def new_customer
        @client = current_user
        @studio = Studio.find(params[:id])
        @user = User.find(3)
        if @user.customer.present?
            @customer = @user.customer
            else
            @customer = @user.build_customer(:stripe_customer_token => @stripe_customer.id, :email => @user.email, :plan_id => 1000, :quantity => 1)
        end
    end 

    def create_for_client
        @client = current_user
        @user = User.find(params[:user_id])

        if  @user.customer.present?
            @stripe_customer = Stripe::Customer.create({description: "Test Stripe Connect", card: params[:stripe_card_token], email: params[:account][:email]}, @client.customer.access_token)
            @stripe_customer.update_subscription(:plan => params[:account][:plan_id], :quantity => 1)  
        else
            @stripe_customer = Stripe::Customer.create({description: "Test Stripe Connect", card: params[:stripe_card_token], email: params[:account][:email]}, @client.customer.access_token)
            @customer = @user.build_customer(:stripe_customer_token => @stripe_customer.id, :email => @user.email, :plan_id => params[:account][:plan_id], :quantity => 1)
            @stripe_customer.update_subscription(:plan => params[:account][:plan_id], :quantity => 1)  
            @customer.last_4_digits = params[:last_4_digits]
        
        if @customer.save
            redirect_to checkin_studio_user_path(@user, @studio, @event), :notice => "Thank you for registering your credit card."
            else
            redirect_to :back, :alert => "Failed to register your credit card."
        end
    end
    end

    def edit
      @user = User.find(params[:user_id])
      render nothing: true
    end
    
    def update
        if Rails.env.development?
            Stripe.api_key
            else
            Stripe.api_key = ENV['STRIPE_API_KEY']
        end
        @user = Profile.find(params[:profile_id])
        @customer = @user.customer    
        @customer.last_4_digits = params[:last_4_digits]
        stripe_customer = Stripe::Customer.retrieve(@customer.stripe_customer_token)
        stripe_customer.card = params[:stripe_card_token]
        stripe_customer.save

        respond_to do |format|
        if @customer.save && @customer.stripe_customer_token.present?
            format.html { redirect_to :back, notice: 'Card successfully updated.' }
            format.json { head :no_content }
        else
            format.html { render :back, alert: 'Card was unsuccessfully updated.' }
            format.json { render json: @message.errors, status: :unprocessable_entity }
        end 
        end
    end
    
    def destroy
        if Rails.env.development?
            Stripe.api_key
            else
            Stripe.api_key = ENV['STRIPE_API_KEY']
        end
        @user = User.find(params[:user_id])
        @customer = @user.customer
        @stripe_customer = Stripe::Customer.retrieve(@customer.stripe_customer_token)
        @stripe_customer.cancel_subscription        
        @customer.destroy
        
        respond_to do |format|
            format.html { redirect_to user_path(@user) }
            format.json { head :no_content }
        end
    end
end
