class SubscriptionsController < ApplicationController
    def create
        if Rails.env.development?
            Stripe.api_key
            else
            Stripe.api_key = ENV['STRIPE_API_KEY']
        end
    end
end
