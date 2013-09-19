class StudiosController < ApplicationController

    def index
        @studios = Studio.all
    end
    
    def show
        @studio = Studio.find(params[:id])
    end
    
    def new
        @studio = Studio.new
    end
    
    def create
        @studio = Studio.create(params[:studio])
        @studio.account_id = current_user.account.id
        
        respond_to do |format|
            if @studio.save
                format.html { redirect_to :back, notice: 'Studio was successfully created.' }
                format.json { head :no_content }
            else
                format.html { redirect_to :back, alert: 'Studio was unsuccessfully created.' }
                format.json { render json: @message.errors, status: :unprocessable_entity }
            end 
        end
    end
    
    def edit
        @studio = Studio.find(params[:id])
    end

    def widget
        @studio = Studio.find(params[:id])
        respond_to do |format|
            format.js {render :layout=>false}
        end
    end
    
    def update
        @studio = Studio.find(params[:id])
        
        respond_to do |format|
            if @studio.update_attributes(params[:studio])
                format.html { redirect_to :back, notice: 'Studio was successfully updated.' }
                format.json { head :no_content }
                else
                format.html { redirect_to :back, alert: 'Studio was unsuccessfully updated.' }
                format.json { render json: @message.errors, status: :unprocessable_entity }
            end
        end
    end
    
    def instructors
        @studio = Studio.find(params[:id])
        @search = @studio.staff.search(params[:search])
        @instructors = @search.all   # load all matching records
        

    end 

    def instructors_database
        @available_instructors = User.joins(:profile).where('is_certified = ?',  true)
        if params[:distance].present?
            @search_database = @available_instructors.near(current_user.studio.gmaps4rails_address, params[:distance]).search(params[:search])
        else
            @search_database = @available_instructors.search(params[:search])
        end
        @instructors_database = @search_database.all   # load all matching records
    end 
    
    def students
        @studio = Studio.find(params[:id])
        @search = @studio.users.search(params[:search])
        @students = @search.all   # load all matching records
    end 
    
    def checkin
        @studio = Studio.find(params[:id])
        @events = @studio.events.where('start_at = ?', Date.today-1)
        
        if params[:event_id].present?
            redirect_to checkin_event_path(@studio.id, params[:event_id])
        end
    end
    
    def checkin_event
        @studio = Studio.find(params[:id])
        @event = @studio.events.find(params[:event_id])
        @search = @studio.users.search(params[:search])
    end

    
    def checkin_user
        @studio = Studio.find(params[:id])
        @user = @studio.users.search(params[:search]).first
        @event = @studio.events.find(params[:event_id])
        
        if @user.is_registered?(@event)
            @user.attends(@event)
        else 
            @user.register!(@event, @studio)
            @user.attends(@event)
        end
        redirect_to :back
    end
    
    def invoice
    end
    
    def details  
        @studio = Studio.find(params[:id])
        
        @json = Studio.all.to_gmaps4rails do |studio, marker|
            marker.json({ :id => studio.id })
        end
    end
    

    def destroy
        @studio = Studio.find(params[:id])
        @studio.destroy
        redirect_to :back
    end
end
