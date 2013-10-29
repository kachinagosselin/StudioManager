class StudiosController < ApplicationController

    def index
        @search = Studio.search(params[:search])
        @studios = @search
    end
    
    def show
        @studio = Studio.find(params[:id])
        @events = @studio.events
    end
    
    def new
        @studio = current_user.account.build_studio
    end
    
    def create
        if current_user.active_role.name == "admin"
        @studio = Studio.create!(params[:studio])
        else
        @studio = current_user.account.build_studio(params[:studio])
        end

        respond_to do |format|
            if @studio.save
                if !current_user.active_role.name == "admin"
                current_user.assign_role("owner", @studio)
                end
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
    
    def update
        @studio = Studio.find(params[:id])
        if params[:location]
            @studio.locations.create!(params[:location])
        end
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
    
    def add_instructor
        @studio = Studio.find(params[:id])
        @user = User.find_by(:email => params[:profile][:email])
        if (@user.present?) && (!@user.instructor?(@studio))
            @user.become_instructor!(@studio)
        else
        @profile = Profile.create!(params[:profile])
        
        respond_to do |format|
            if @profile.save
                format.html { redirect_to :back }                
                format.json { head :no_content, notice: 'Instructor was added to the database. Please email instructor so that they can join our site.'  }
                else
                format.html { redirect_to :back, alert: 'Instructor was not saved.' }
                format.json { render json: @message.errors, status: :unprocessable_entity }
            end 
        end
        end
    end
    
    def remove_instructor
        @studio = Studio.find(params[:id])
        @user = User.find(params[:user_id])
        @user.remove_instructor!(@studio)
    end

    def instructors_database
        @available_instructors = Profile.available_instructors
        # When able to take in account availability use:
        # Profile.with_role(:instructor, :any).where(:is_available => true)
        if params[:search].present?
            if params[:search][:distance].present?
                @distance = params[:search][:distance]
                params[:search].delete :distance
            end
        end
        
        @search_database = @available_instructors.search(params[:search])

        if params[:search].present?
        if params[:search][:distance].present?
            @search_database = Profile.near(current_user.account.studio.gmaps4rails_address, @distance).where('is_certified = ?',  true).search(params[:search])
        end
        end
        
        @instructors_database = @search_database   # load all matching records
    end 
    
    def checkin
        @studio = Studio.find(params[:id])
        @events = @studio.events.where('start_at BETWEEN ? AND ?', DateTime.now - 15.minutes, DateTime.now.end_of_day())
        
        if params[:event_id].present?
            redirect_to checkin_event_path(@studio.id, params[:event_id])
        end
    end
    
    def checkin_event
        @studio = Studio.find(params[:id])
        @event = @studio.events.find(params[:event_id])
        @search = @studio.users.search(params[:search])
    end

    def 
    
    def checkin_user_directly
        @studio = Studio.find(params[:id])
        @event = @studio.events.find(params[:event_id])
        @user = User.find(params[:user_id])
        @paid = false

            #if active memberships are available
            if @user.paid_for_class?(@studio)
                if @user.is_registered?(@event)
                    @user.attends(@event)
                    redirect_to :back
                    else 
                    @user.register!(@event, @studio, true)
                    @user.attends(@event)
                    redirect_to :back
                end
                else
                redirect_to :back #new_purchase
            end
    end
    
    def checkin_user
        @studio = Studio.find(params[:id])
        @event = @studio.events.find(params[:event_id])
        @user = @studio.users.search(params[:search]).first
        @paid = false
        
        #if user is a student of the studio
        if @user.present?
            a
            #if active memberships are available
            if @user.paid_for_class?(@studio)
                d
                if @user.is_registered?(@event)
                    @user.attends(@event)
                    done
                    redirect_to :back
                else 
                    @user.register!(@event, @studio, true)
                    @user.attends(@event)
                    here
                    redirect_to :back
                end
            else
                redirect_to :back #new_purchase
            end
            
        #if user is not a student of the studio
        elsif User.search(params[:search]).present?            
            redirect_to :back #student_login
        #if user does not have an account with our software
        else
            redirect_to :back #student_registration            
        end
    end
    
    def _embed
        @studio = Studio.find(params[:id])
    end

    def _week_view
        @studio = Studio.find(params[:id])
        @events = Studio.events
    end

    def destroy
        @studio = Studio.find(params[:id])
        @studio.destroy
        redirect_to :back
    end
end
