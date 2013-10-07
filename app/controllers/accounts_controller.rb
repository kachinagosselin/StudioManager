class AccountsController < ApplicationController
       def destroy
        if Rails.env.development?
            Stripe.api_key
            else
            Stripe.api_key = ENV['STRIPE_API_KEY']
        end
        @user = User.find(params[:user_id])
        @account = @user.accounts.find(params[:id])

        stripe_customer = Stripe::Customer.retrieve(@user.customer.stripe_customer_token)
        stripe_customer.cancel_subscription
           
        @user.remove_role :owner, @account.studio
        @account.destroy
        redirect_to :back, :notice => "You have successfully removed your studio account!"
    end
    
end
