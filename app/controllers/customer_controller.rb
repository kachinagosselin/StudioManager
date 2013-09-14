class CustomerController < ApplicationController
        
        def new
            @user = User.find(params[:user_id])
            @customer = @user.customers.new
        end
        
        def register
            @user = current_user
            @user.stripe_code = params[:code]
            if @user.save                
                redirect_to root_path, :notice => "Thank you for giving us access to your stripe account."
                else
                redirect_to :back, :alert => "Failed to register your stripe account."
            end

        end 
    
        def create
            if Rails.env.development?
                Stripe.api_key
            else
                Stripe.api_key = ENV['STRIPE_API_KEY']
            end
        
            @user = User.find(params[:user_id])
            @stripe_customer = Stripe::Customer.create(description: params[:account][:email], plan: params[:account][:plan_id], card: params[:stripe_card_token], email: params[:account][:email])
            @customer = @user.build_customer(:stripe_customer_token => @stripe_customer.id, :email => @user.email, :plan_id => params[:account][:plan_id], :quantity => 1)
            @customer.last_4_digits = params[:account][:last_4_digits]
            
            if @customer.save
                @user.add_role :student
                
                redirect_to edit_user_registration_path, :notice => "Thank you for registering your credit card. Please add details about your studio to be listed on our site."
                else
                redirect_to :back, :alert => "Failed to register your credit card."
            end
        end
    
        def create_for_client
            Stripe.api_key = @user.customer.access_token

            @user = User.find(params[:user_id])
            @stripe_customer = Stripe::Customer.create(description: "Test Stripe Connect", plan: params[:account][:plan_id], card: params[:stripe_card_token], email: params[:account][:email])
            @customer = @user.build_customer(:stripe_customer_token => @stripe_customer.id, :email => @user.email, :plan_id => params[:account][:plan_id], :quantity => 1)
            @customer.last_4_digits = params[:account][:last_4_digits]
            
            if @customer.save
                @user.add_role :student
                
                redirect_to edit_user_registration_path, :notice => "Thank you for registering your credit card."
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
            stripe_customer = Stripe::Customer.retrieve(@customer.stripe_customer_token)
            
            #if this is the last subscription, cancel the subscription
            stripe_customer.cancel_subscription
            @subscription.destroy
            @user.remove_role :student
            @user.save
            redirect_to :back, :notice => "You have successfully removed your studio account!"
        end
        
        
        
    end

