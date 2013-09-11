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
    end
    
    def new
        @studio = Studio.find(params[:studio_id])
        @event = @studio.events.new
    end

    def create
        @studio = Studio.find(params[:studio_id])
        @event = @studio.events.create(params[:event])
        respond_to do |format|
            if @event.save
                format.html { redirect_to calendar_path(@studio), notice: 'Event was successfully created.' }
                format.json { head :no_content }
                else
                format.html { render :action => 'new', alert: 'Event was unsuccessfully created.' }
                format.json { render json: @message.errors, status: :unprocessable_entity }
            end 
        end
    end
    
    def edit
        @studio = Studio.find(params[:studio_id])
        @event = Event.find(params[:id])
    end
    
    def update
        @studio = Studio.find(params[:studio_id])
        @event = Event.find(params[:id])
        
        respond_to do |format|
            if @event.update_attributes(params[:event])
                format.html { redirect_to studio_event_path(@studio, @event), notice: 'Event was successfully updated.' }
                format.json { head :no_content }
                else
                format.html { render action: "edit" }
                format.json { render json: @message.errors, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @event = Event.find(params[:id])
        if @event.users.present?
        @event.archive = true
        else
        @event.destroy
        end
        redirect_to :back
    end
end
