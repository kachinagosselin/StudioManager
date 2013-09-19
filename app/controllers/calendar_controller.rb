class CalendarController < ApplicationController
  
  def index
    @month = (params[:month] || (Time.zone || Time).now.month).to_i
    @year = (params[:year] || (Time.zone || Time).now.year).to_i
    @shown_month = Date.civil(@year, @month)
      
    @studio = Studio.find(params[:studio_id])
    @search = @studio.events.search(params[:search])
    @events = @search.all   # load all matching records
      
  end
    
  def professional
        @month = (params[:month] || (Time.zone || Time).now.month).to_i
        @year = (params[:year] || (Time.zone || Time).now.year).to_i
        @shown_month = Date.civil(@year, @month)
        
        @user = User.find(params[:user_id])
        @search = Events.search(params[:search])
        @events = @search.all   # load all matching records
        
    end

end
