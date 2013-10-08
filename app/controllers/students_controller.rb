class StudentsController < ApplicationController
  
  def index
      if (current_user.active_role.name == "owner" || current_user.active_role.name == "staff")
          @studio = Studio.find(current_user.active_role.resource_id)
          @search = @studio.students.search(params[:search])
      elsif current_user.active_role.name == "professional"
          @search = current_user.profile.students.search(params[:search])
      end
      @students = @search.all   # load all matching records  

  end
    
  def show
      
  end
  
end
