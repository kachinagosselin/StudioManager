class UsersController < ApplicationController
  before_filter :authenticate_user!
    account_sid = 'AC01c958af473d4bf154e554c1aadf681f'
    auth_token = 'ebe0a98d4cd312fd7f138ccf9444618a'
    
  def index
      @users = User.all
  end

  def show
      @user = User.find(params[:id])
      @profile = Profile.where(:user_id => params[:id]).first
      @events = @profile.teaching_events_this_week
  end 

  def history
      @profile = Profile.where(:user_id => params[:id]).first
      @attended = @profile.find_attended
      @registered = @profile.find_registered
  end 
    
  def dashboard
    @user = User.find(params[:id])
  end 
    
  def change_role
      role = Role.find(params[:id])
      current_user.change_active_role_to(role)
      if current_user.active_role.name == "student"
          redirect_to root_path
      else
          redirect_to :back
      end
  end
    
  def set_map_view
      @profile = current_user.profile
      @profile.toggle_map
  end
    
  def search
      @search = Profile.search(params[:search]).first
      @result = @search   # load all matching records

        if params[:resource_type] == "Studio"
          object = Studio.find(params[:resource_id])
        elsif params[:resource_type] == "User"
          object = User.find(params[:resource_id])
        end
      # In the case that we are using search to assign a role to the user
      if @result.present? && params[:role].present?
        @result.assign_role(params[:role], object)
      end

      # In the case that we are using search to register the user for a class
      if @result.present? && params[:event].present?
        @active = @result.active_membership(object)
      end
      
      @json = !@result.present?
      respond_to do |format|
          format.js
    end
  end
    
  def new_student
      @studio = Studio.find(params[:studio_id])
      @event = Event.find(params[:event_id])
      if params[:user][:memberships].present?
          @membership = @studio.memberships.find(params[:user][:memberships])
      elsif params[:user][:packages].present?
          @package = @studio.packages.find(params[:user][:packages])
      end
      @user = User.create(:name => params[:user][:name], :email => params[:user][:email], :password => params[:user][:password], :password_confirmation => params[:user][:password_confirmation])
      if params[:signed_waiver] = true
          @signed = true
          if @user.save
              @user.save_customer_for_studio(current_user, @studio, params[:stripe_card_token], params[:last_4_digits])
              if @membership.present?
                  @user.add_membership(current_user, @membership)
                  @user.purchase!(@studio, @membership, "membership", false)
              elsif @package.present?
                  @user.add_credits(current_user, @package)
                  @user.purchase!(@studio, @package, "package", false)
                  @user.spend_credit
              end
              @studio.add_student(@user, @signed)
              @user.register!(@event, @studio, true)
              @user.attends(@event)
              redirect_to :back
          else
              redirect_to :back, alert: 'Student was not successfully created.' 
          end 
      end
  end 
    
    def login_new_student
        @new_user = User.find(2)
        @name = new_user.name
    end 
    
    def students
        @professional = User.find(params[:id])
        @search = @professional.students.search(params[:search])
        @students = @search.all   # load all matching records
    end 

    def _embed
        @user = User.find(params[:id])
    end
end
