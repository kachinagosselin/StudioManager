class ProfilesController < ApplicationController
    
    def index
        @profiles = Profile.all
        
        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @profiles }
        end
    end
    
    def show 
        @profile = Profile.find(params[:id])
    end

    def create
        @profile = Profile.create(params[:profile])
        
        if params[:user_type].present? && params[:account_type].present?
        @profile.assign_role(params[:user_type], params[:account_type])
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
    
    def update
        @profile = Profile.find(params[:id])
        
        # Determine if user is 
        if params[:profile][:is_certified] == "1"
            @user.add_role :instructor
        elsif params[:profile][:is_certified] == "0"
            @user.remove_role :instructor
        end
        
        #Cannot change major attributes of profile
        if @profile.user.present?
            params[:name].destroy
            params[:email].destroy
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
