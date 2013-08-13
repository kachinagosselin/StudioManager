class Users::InvitationsController < Devise::InvitationsController
  
  def new 
      @user = User.create!
  end
    
    
end