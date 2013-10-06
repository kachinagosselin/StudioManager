class ReportsController < ApplicationController
  
  def index
      @studio = Studio.find(current_user.active_role.resource_id)

  end
  
end
