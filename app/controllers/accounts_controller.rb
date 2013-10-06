class AccountsController < ApplicationController
    
    def new
        @user = User.find(params[:user_id])
        @account = @user.build_account
    end
    
    def create
        if Rails.env.development?
            Stripe.api_key
        else
            Stripe.api_key = ENV['STRIPE_API_KEY']
        end
        @user = User.find(params[:user_id])
            
        if  @user.customer.present?
            stripe_customer = Stripe::Customer.retrieve(@user.customer.stripe_customer_token)
            @account = @user.build_account(params[:account])
            @account.update_attribute(:is_active, true)
            stripe_customer.update_subscription(:plan => 1, :quantity => 1)  
        else
        # if the credit card is valid create new customer and accounts
            @account = @user.build_account(:plan_id => 1, :user_id => params[:account][:user_id], :email => params[:account][:email])
            @stripe_customer = Stripe::Customer.create(description: params[:account][:email], plan: params[:account][:plan_id], card: params[:stripe_card_token], email: params[:account][:email])
            @customer = @user.build_customer(:stripe_customer_token => @stripe_customer.id, :email => @user.email, :plan_id => params[:account][:plan_id], :quantity => 1)
            @customer.last_4_digits = params[:last_4_digits]
            @customer.save
            @account.update_attribute(:is_active, true)
            @account.update_attribute(:stripe_customer_token, @stripe_customer.id)
        end
        
        if @account.save
            if params[:account][:plan_id] = 'studio-basic'
                @user.add_role :owner
            elsif params[:account][:plan_id]= 'professional-basic'
                @user.add_role :professional
            end
            redirect_to edit_user_registration_path, :notice => "Thank you for registering your credit card. Please add details about your studio to be listed on our site."
        else
            redirect_to :back, :alert => "Failed to register your credit card."
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
        @account = @user.accounts.find(params[:id])
        stripe_customer = Stripe::Customer.retrieve(@customer.stripe_customer_token)

        #if this is the last subscription, cancel the subscription
        stripe_customer.cancel_subscription
        @subscription.destroy
        @user.remove_role :owner
        @user.save
        @account.destroy
        redirect_to :back, :notice => "You have successfully removed your studio account!"
    end
    
    

end
