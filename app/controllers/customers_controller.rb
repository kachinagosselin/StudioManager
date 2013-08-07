class CustomersController < ApplicationController
    def create 
        if Rails.env.development?
            Stripe.api_key
            else
            Stripe.api_key = ENV['STRIPE_API_KEY']
        end
        @user = User.find(params[:user_id])
        @stripe_customer = Stripe::Customer.create(description: @user.email, card: params[:stripe_card_token])
        @customer = @user.build_customer(:stripe_customer_token => @stripe_customer.id)
        @customer.last_4_digits = params[:last_4_digits]
     
        respond_to do |format|
        if @customer.save
            format.html { redirect_to :back, notice: 'Card successfully added.' }
            format.json { head :no_content }
        else
            format.html { render :back, alert: 'Card was unsuccessfully added.' }
            format.json { render json: @message.errors, status: :unprocessable_entity }
        end 
        end
    end

    def edit
      @user = User.find(params[:user_id])
    end
    
    def update
        if Rails.env.development?
            Stripe.api_key
            else
            Stripe.api_key = ENV['STRIPE_API_KEY']
        end
        @user = User.find(params[:user_id])
        @customer = @user.customer    
        @customer.last_4_digits = params[:last_4_digits]
        stripe_customer = Stripe::Customer.retrieve(@customer.stripe_customer_token)
        stripe_customer.card = params[:stripe_card_token]
        stripe_customer.save

        respond_to do |format|
        if @customer.save
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
