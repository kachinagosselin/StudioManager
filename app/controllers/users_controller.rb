class UsersController < ApplicationController
  before_filter :authenticate_user!
    account_sid = 'AC01c958af473d4bf154e554c1aadf681f'
    auth_token = 'ebe0a98d4cd312fd7f138ccf9444618a'
    
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    
  end 

    def history
        @user = User.find(params[:id])
        
    end 

    def student?(event)
        students.find_by(event_id: event.id)
    end
    
    def enroll!(event)
        students.create!(event_id: event.id)
    end

end
