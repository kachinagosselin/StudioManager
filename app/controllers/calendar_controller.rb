class CalendarController < ApplicationController
  
  def studio_index
    @month = (params[:month] || (Time.zone || Time).now.month).to_i
    @year = (params[:year] || (Time.zone || Time).now.year).to_i
    @shown_month = Date.civil(@year, @month)
      
    @studio = Studio.find(params[:studio_id])
    @search = @studio.events.search(params[:search])
    @events = @search.all   # load all matching records
      respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @events.as_json }
      end
  end
    
  def professional_index
    @month = (params[:month] || (Time.zone || Time).now.month).to_i
    @year = (params[:year] || (Time.zone || Time).now.year).to_i
    @shown_month = Date.civil(@year, @month)
        
    @professional = User.find(params[:user_id])
    @search = @professional.events.search(params[:search])
    @events = @search.all   # load all matching records
      respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @events.as_json }
      end
    end
    
    def show 
        @studio = Studio.find(params[:id])
        @events = @studio.events
    end

end
