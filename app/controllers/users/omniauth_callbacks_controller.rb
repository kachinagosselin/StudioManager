class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def stripe_connect
    # Delete the code inside of this method and write your own.
      @user = current_user
      if @user.save_with_stripe_account(params[:code])
          redirect_to edit_registration_path(@user), :notice => "Thank you for giving us access to your stripe account. Please add details about your studio to continue."
          else
          redirect_to :back, :alert => "Failed to register your stripe account."
      end   
  end
end