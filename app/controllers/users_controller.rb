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
    
  def private_dashboard
    @user = User.find(params[:id])
  end 
    
    def private_students
        @user = User.find(params[:id])
    end 
    
    def private_memberships
        @user = User.find(params[:id])
    end 
    
    def private_coupons
        @user = User.find(params[:id])
    end 
    
  def new_student
      @studio = Studio.find(params[:studio_id])
      @event = Event.find(params[:event_id])
      @user = User.create(:name => params[:user][:name], :email => params[:user][:email], :password => params[:user][:password], :password_confirmation => params[:user][:password_confirmation])
      if params[:signed_waiver] = true
          @signed = true
          @studio.add_student(@user, @signed)
      if @user.save
          redirect_to invoice_path(@studio, @user), notice: 'Student was successfully created.' 
      else
          redirect_to :back, alert: 'Student was not successfully created.' 
      end 
      end
  end 

end
