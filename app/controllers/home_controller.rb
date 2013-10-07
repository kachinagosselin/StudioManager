class HomeController < ApplicationController
  def index
      @user_events = current_user.registered.all
      
      @json = Studio.all.to_gmaps4rails do |studio, marker|
          events = studio.events.as_json
          html = "<div class='row'>
          <div class='col-lg-6' style='padding-right:30px;'>
          <h3>Offers for #{studio.name} </h3>
          </div>
          
          <div class='col-lg-5' style='margin-top:25px;'>
          <div class='panel panel-primary' >
          <div class='panel-heading'>
          <h5 class='panel-title'>Studio Offerings </h5>
          </div>
          
          <ul class='list-group' style='list-style-type:none;'>"
          
          studio.memberships.each do |membership|
              name = membership.name
              html = html + "
              <li><a href='#' class='list-group-item'>
              <p class='list-group-membership-membership'>#{name}</p></a></li>"
          end
          
          html = html + "</ul></div></div></div>"
          
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
