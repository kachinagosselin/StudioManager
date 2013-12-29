class SessionsController < ApplicationController

  def index
    @object = current_user.active_role.resource
    @search = @object.sessions.search(params[:search])

    @sessions = @search.all   # load all matching records  
  end
  
  def show
    @session = Session.find(params[:id])
  end

  def new
  end

  def create
    @session = Session.new(params[:session])

    respond_to do |format|
      if @session.save
        format.html { redirect_to :back }
        format.js
      else
        format.html { redirect_to :back, alert: 'Session was unsuccessfully created.' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end 
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
