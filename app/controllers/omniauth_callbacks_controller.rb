class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def stripe_connect
    # Delete the code inside of this method and write your own.
      code = self.stripe_code
      customer = ActiveSupport::JSON.decode(`curl -X POST https://connect.stripe.com/oauth/token -d client_secret=#{ENV['STRIPE_SECRET_KEY']} -d code=#{self.stripe_code} -d grant_type=authorization_code`)
      raise customer.inspect  
  end
end