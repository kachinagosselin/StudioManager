class ProfilesController < ApplicationController
    
    def index
        @profile = Profile.find(params[:id])
        
        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @memberships }
        end
    end
    
    def show 
    end
    
    def new
        @user = User.find(params[:user_id])
        @profile = @user.build_profile
    end

    def create
        @profile = Profile.create(params[:profile])
        if params[:user_type] == "instructor"
            @profile.become_instructor!(current_user.account.studio)
        else params[:user_type] == "student"
            if params[:account_type] == "studio"
            @profile.become_student!(current_user.account.studio)
            elsif params[:account_type] == "professional"
            @profile.become_student!(current_user)    
            end
        end
        respond_to do |format|
            if @profile.save
                format.html { redirect_to :back }                
                format.json { head :no_content }
                else
                format.html { render :action => 'new', alert: 'Profile was unsuccessfully created.' }
                format.json { render json: @message.errors, status: :unprocessable_entity }
            end 
        end
    end

    def edit
        @user = User.find(params[:user_id])
        @profile = Profile.find(params[:id])
    end
    
    def update
        @user = User.find(params[:user_id])
        @profile = @user.profile
        if params[:profile][:is_certified] == "1"
            @user.add_role :instructor
        end
        
        respond_to do |format|
            if @profile.update_attributes(params[:profile])
                format.html { redirect_to :back, notice: 'Profile was successfully updated.' }
                format.json { head :no_content }
                else
                format.html { redirect_to :back }
                format.json { render json: @message.errors, status: :unprocessable_entity }
            end
        end
    end

    def destroy
    end
end
