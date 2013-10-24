class CalendarController < ApplicationController
  
  def index
    @month = (params[:month] || (Time.zone || Time).now.month).to_i
    @year = (params[:year] || (Time.zone || Time).now.year).to_i
    @shown_month = Date.civil(@year, @month)
      
    if current_user.active_role.name == "owner"
        
    @studio = Studio.find(current_user.active_role.resource_id)
    @search = @studio.events.search(params[:search])
    elsif current_user.active_role.name == "professional"
    @search = current_user.events.search(params[:search])
    end
      
    @events = @search.all   # load all matching records
    respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @events.as_json }
    end
  end
  
end
