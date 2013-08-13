class HomeController < ApplicationController
  def index
    @users = User.all
      @studios = Studio.all
      @json = Studio.all.to_gmaps4rails
  end
end
