class HomeController < ApplicationController
  def index
    @users = User.all
      @studios = Studio.all

      
      @json = Studio.all.to_gmaps4rails do |studio, marker|
          marker.json({ :id => studio.id,
                      :name => studio.name})
      end
      respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @json }
      end

  end
end
