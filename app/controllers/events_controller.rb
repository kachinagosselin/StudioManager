class EventsController < ApplicationController
    
    def index
        @events = Event.all
    end
    
    def show
        @event = Event.find(params[:id])
    end
    
    def new
        @event = Event.new
    end

    def create
        @event = Event.create(params[:event])
        
        respond_to do |format|
            if @event.save
                format.html { redirect_to root_path(), notice: 'Event was successfully created.' }
                format.json { head :no_content }
                else
                format.html { render :action => 'new', alert: 'Event was unsuccessfully created.' }
                format.json { render json: @message.errors, status: :unprocessable_entity }
            end 
        end
    end
    
    def edit
        @event = Event.find(params[:id])
    end
    
    def update
        @event = Event.find(params[:id])
        
        respond_to do |format|
            if @event.update_attributes(params[:event])
                format.html { redirect_to event_path(@event), notice: 'Event was successfully updated.' }
                format.json { head :no_content }
                else
                format.html { render action: "edit" }
                format.json { render json: @message.errors, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @event = Event.find(params[:id])
        @event.destroy
        redirect_to :back
    end
end
