class SettingsController < ApplicationController
  
  def index
      @resource = current_user.active_role.resource
  end
  
  def upgrade
  end

  def studio
      @studio = current_user.account.studio
  end

  def profile
  end
  
  def notifications
  end

end
