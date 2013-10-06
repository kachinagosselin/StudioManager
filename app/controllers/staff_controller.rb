class StaffController < ApplicationController
  
  def index
      if current_user.active_role.name == "owner"
          @studio = Studio.find(current_user.active_role.resource_id)
          @search = @studio.staff.search(params[:search])
          @instructors = @search.all   # load all matching records
      end
  end
    
  def show
      
  end
  
end
