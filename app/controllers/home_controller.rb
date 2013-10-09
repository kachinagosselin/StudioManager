class HomeController < ApplicationController
  def index
      if user_signed_in?
      @user_events = current_user.registered
      
      @json = Location.all.to_gmaps4rails do |location, marker|
          studio = location.studio
          events = studio.events.as_json
          html = studio.html
          
          marker.json({:id => studio.id,
                      :name => studio.name,
                      :html => html,
                      :events => events
                      })
      end
      respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @user_events.as_json }
      end
    end
  end
    
end
