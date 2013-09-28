class EventsController < ApplicationController
    
    def index
        @studio = Studio.find(params[:studio_id])
        @events = @studio.events
        
        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @events.as_json }
        end
    end
    
    def show
        @event = Event.find(params[:id])
        @registered = Profile.find_registered(@event)
        if @event.professional_id.present?
        @professional = User.find(@event.professional_id)
        else
        @studio = @event.studio
        end
    end

    def create
        d
        @event = Event.create(params[:event])
        
        respond_to do |format|
            if @event.save
                format.html { redirect_to :back, notice: 'Event was successfully created.' }
                format.json { head :no_content }
                else
                format.html { redirect_to :back, alert: 'Event was unsuccessfully created.' }
                format.json { render json: @message.errors, status: :unprocessable_entity }
            end 
        end
    end
    
    def edit

    end
    
    def update
        @event = Event.find(params[:id])
        
        respond_to do |format|
            if @event.update_attributes(params[:event])
                format.html { redirect_to :back, notice: 'Event was successfully updated.' }
                format.json { head :no_content }
                else
                format.html { redirect_to :back }
                format.json { render json: @message.errors, status: :unprocessable_entity }
            end
        end
    end
    
    def purchase
        @studio = Studio.find(params[:studio_id])
        @event = Event.find(params[:id])
        @account = Account.find(@studio.account_id)
        @client = @account.user
        @user = current_user
        @stripe_charge = Stripe::Charge.create({
                                               :amount => 1600,
                                               :currency => "usd",
                                               :card => @user.customer.stripe_customer_token,
                                               :description => "Charge to test purchase of class"
                                               }, @client.customer.access_token
                                                 )
        @user.register!(@event, @studio, false)
        
    end
    
    def remote_checkin
        @event = Event.find(params[:id])
        if params[:studio_id].present?
            @studio = Studio.find(params[:studio_id])
            @search = @studio.students.search(params[:search]).first
        elsif params[:user_id].present?
            @professional = User.find(params[:user_id])
            @search = @professional.students.search(params[:search]).first
        end
    end
    
    # Roles for events: registered, attended, canceled (by user or studio)
    def cancel_attendance
        @event = Event.find(params[:id])
        @profile = Profile.find(params[:profile_id])
        @profile.remove_role :attended, @event
    end
    
    def add_attendance
        @event = Event.find(params[:id])
        @profile = Profile.find(params[:profile_id])
        if !@profile.has_role? :canceled, @event
        @profile.add_role :attended, @event
        end
        redirect_to :back
    end
    
    # Notifies users that class has been canceled - refunds purchase. 
    def cancel_registration
        @event = Event.find(params[:id])
        @profile = Profile.find(params[:profile_id])
        @profile.add_role :canceled, @event
        redirect_to :back
    end
    
    # Notifies users that class has been canceled - refunds purchase. 
    def remove_registration
        @event = Event.find(params[:id])
        @profile = Profile.find(params[:profile_id])
        @profile.remove_role :registered, @event
        redirect_to :back
    end
    
    def add_registration
        @event = Event.find(params[:id])
        @search = Profile.search(params[:search])
        @profile = @search.first
        if @profile.present?
            @profile.add_role :registered, @event
        if params[:studio_id].present?
            @studio = Studio.find(params[:studio_id])
            @instructor = Profile.where(:name => @event.instructor).first
            @profile.add_role :student, @studio
            @profile.add_role :student, @instructor
        elsif params[:user_id].present?
            @professional = User.find(params[:user_id]).profile
            @profile.add_role :student, @professional
        end    
            redirect_to :back, notice: 'User was successfully added to class registration list.'
        else
            redirect_to :back, alert: 'User is not apart of our the system and must register a new account.'
        end
    end
    
    def new_registration
        @event = Event.find(params[:id])
        @profile = Profile.create(params[:profile])
        if @profile.save
            @profile.add_role :registered, @event
            if params[:studio_id].present?
                @studio = Studio.find(params[:studio_id])
                @instructor = Profile.where(:name => @event.instructor).first
                @profile.add_role :student, @studio
                @profile.add_role :student, @instructor
            elsif params[:user_id].present?
                @professional = User.find(params[:user_id]).profile
                @profile.add_role :student, @professional
            end    
            redirect_to :back, notice: 'User was successfully added to class registration list.'
            else
            redirect_to :back, alert: 'User is not apart of our the system and must register a new account.'
        end
    end
    
    def archive
        
    end
    
    def destroy
        @event = Event.find(params[:id])
        if @event.users.present?
            @event.update_attributes(:archive => true)
        else
            @event.destroy
        end
        redirect_to :back
    end
end
