class ReportsController < ApplicationController
  
  def index
      @resource = current_user.active_role.resource
  end
  
  def attendance
      @resource = current_user.active_role.resource
  end

  def revenue
      @resource = current_user.active_role.resource
  end
end
