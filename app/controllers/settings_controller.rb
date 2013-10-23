class SettingsController < ApplicationController
  
  def index
      @resource = current_user.active_role.resource
  end
  
  def upgrade
      @resource = current_user.active_role.resource
  end

  def studio
      @resource = current_user.active_role.resource
  end
end
