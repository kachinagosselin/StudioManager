class ProfilesController < ApplicationController
 
    def index
        @user = User.find(params[:user_id)
        @profile = @user.profile
        
        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @profile }
        end
    end
    
    
    def update
        @user = User.find(params[:user_id)
        @profile = @user.profile
        
        respond_to do |format|
            if @profile.update_attributes(params[:profile])
                format.html { redirect_to edit_registration_path(@user)}
                format.json { head :no_content }
                else
                format.html { redirect_to :back }
                format.json { render json: @message.errors, status: :unprocessable_entity }
            end
        end
    end

end
