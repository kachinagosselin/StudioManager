class SettingsController < ApplicationController
  
  def index
      @resource = current_user.active_role.resource
  end
  
  def profile
  end

  def upgrade
  end

  def studio
      @studio = current_user.account.studio
      @json = @studio.locations.all.to_gmaps4rails
  end
  
  def billing
  end

  def notifications
  end

end
