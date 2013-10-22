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
    
        if params[:user_type].present? && params[:resource].present?
        @profile.assign_role(params[:user_type], params[:resource])
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
        
        if params[:add_professional_role] == "yes"
            @profile.user.assign_role("professional", @profile.user)
        end
        
        if params[:profile][:availability_attributes].present?
        (0...6).each do |i|
        n = i.to_s
        subset = params[:profile][:availability_attributes][n]
        availability = @profile.availabilities.where(:day_of_week => i).first
            availability.update_attributes(:start_at => subset[:start_at], :end_at => subset[:end_at])
        end
        params[:profile].delete :availability_attributes
        end
        
        #Cannot change major attributes of profile
        if @profile.user.present?
            if params[:name].present?
            params[:name].destroy
            end
            if params[:email].present?
            params[:email].destroy
            end
        end
        
        respond_to do |format|
            if @profile.update_attributes(params[:profile])
                format.html { redirect_to :back, notice: 'Profile was successfully updated.' }
                format.json { head :no_content }
                else
                format.html { redirect_to :back, alert: 'There was an error updating profile.' }
                format.json { render json: @message.errors, status: :unprocessable_entity }
            end
        end
    end

    def destroy
    end
end
