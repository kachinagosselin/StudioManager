class ReportsController < ApplicationController
  
  def index
      @resource = current_user.active_role.resource

  end
  
end
