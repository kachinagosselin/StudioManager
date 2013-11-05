class HomeController < ApplicationController

  def index
      if user_signed_in?
      @user_events = current_user.registered
      @user = current_user
      @json = Location.all.to_gmaps4rails do |location, marker|
          studio = location.studio
          events = studio.events.as_json
        html = "<div class='row'>
        <div class='col-lg-6' style='padding-right:30px;'>
        <h3>#{studio.name} </h3>"
        @locations = studio.locations
        if @locations.count == 1
            html = html +
            "<p> Address: #{studio.address} #{studio.city}, #{studio.state} </p>"
        elsif @locations.count > 1 
            html = html + "<p> Located at the following addresses: </p>" 
            @locations.each do |loc|
            html = html + 
            "<p> #{loc.address} #{loc.city}, #{loc.state} </p>"
            end
        end
        
        if studio.main_phone.present?
            html = html +
            "<p> Phone: #{studio.main_phone} </p>"
        end

        if studio.website.present?
            html = html +
            "<p> Website: <a>#{studio.website}</a></p>"
        end
        
        if false
            html = html + 
            "<p> #{studio.description} </p>"
        end
        
        html = html +
        "</div>
        
        <div class='col-lg-5' style='margin-top:25px;'>
        <div class='panel panel-primary' >
        <div class='panel-heading'>
        <h5 class='panel-title'>Studio Offerings" 
        if !studio.packages.present? && !studio.memberships.present?
          html = html + " - there are none available through this site"
           html = html + "</h5>
        </div>"
        else
        html = html + "</h5>
        </div>
        
        <ul class='list-group' style='list-style-type:none;'>"
        
        studio.memberships.each do |membership|
            name = membership.title
            id = membership.id
            profile_id = @user.profile.id
            if membership.purchased?(@user.profile)
            html = html + "
            <li class='list-group-item'><b>#{name} </b> (Purchased) </li>"
            else
            html = html + "
            <li class='list-group-item'>#{name} <a href='/memberships/#{id}/purchase/#{profile_id}' style='margin-top:-5px;' class='btn btn-primary btn-sm pull-right'>
            Purchase</a></li>"
            end
        end
        
        html = html + "</ul>"

        end 
        html = html + "</div></div></div>"          
          marker.json({:id => studio.id,
                      :name => studio.name,
                      :html => html,
                      :events => events
                      })
      end
    end
      respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @user_events.as_json }
      end
  end

  def about 

  end

  def calendar
      if user_signed_in?
        @user_events = current_user.registered
        @events = @user_events
      end
  end

  def map
      if user_signed_in?
      @user = current_user
      @locations = Location.near(current_user.profile.address, 25).all
        if !@locations.present?
          @locations = Location.all
        end

        @json = @locations.to_gmaps4rails do |location, marker|
            studio = location.studio
            events = studio.events.as_json
            marker.infowindow render_to_string(:partial => "/studios/display_marker", :locals => {:studio => studio})        
            marker.json({:id => studio.id,
                        :name => studio.name,
                        })
        end
      else
        @json = Location.all.to_gmaps4rails do |location, marker|
            studio = location.studio
            marker.infowindow render_to_string(:partial => "/studios/display_marker", :locals => {:studio => studio})        
            marker.json({:id => studio.id,
                        :name => studio.name
                        })
        end
      end
      respond_to do |format|
          format.html # index.html.erb
          format.json 
      end
  end

  def events
        @search = Event.sorted.upcoming.search(params[:search])
        @events = @search
  end
    
end
