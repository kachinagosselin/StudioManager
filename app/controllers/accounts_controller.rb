class AccountsController < ApplicationController
    
    def new
        @user = User.find(params[:user_id])
        @account = @user.accounts.new
    end
    
    def create
        if Rails.env.development?
            Stripe.api_key
            else
            Stripe.api_key = ENV['STRIPE_API_KEY']
        end
        
        @user = User.find(params[:user_id])
        @customer = @user.customer
        
        if  @customer.present?
            stripe_customer = Stripe::Customer.retrieve(@customer.stripe_customer_token)
            @account = @user.accounts.build(params[:account])
            @account.update_attribute(:is_active, true)
            stripe_customer.update_account(:plan => params[:account][:plan_id], :quantity => 1)      
        else
        # if the credit card is valid create new customer and accounts
            @account = @user.accounts.build(:plan_id => params[:account][:plan_id], :user_id => params[:account][:user_id], :email => params[:account][:email])
            @stripe_customer = Stripe::Customer.create(description: params[:account][:email], plan: params[:account][:plan_id], card: params[:stripe_card_token], email: params[:account][:email])
            @customer = @user.build_customer(:stripe_customer_token => @stripe_customer.id)
            @customer.save
            @account.stripe_customer_token = @stripe_customer.id
            @customer.last_4_digits = params[:last_4_digits]
        end
        
        if @account.save
            @customer.save
            @account.update_attribute(:is_active, true)

            redirect_to new_studio_path(), :notice => "Thank you for registering your credit card."
            else
            redirect_to :back, :alert => "Failed to register your credit card."
        end
    end
    
    def unsubscribe
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
        redirect_to :back, :notice => "You have successfully removed your studio account!"
    end

end
