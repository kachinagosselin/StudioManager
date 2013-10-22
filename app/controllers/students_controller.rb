class StudentsController < ApplicationController
  
  def index
    if (current_user.active_role.name == "owner" || current_user.active_role.name == "staff")
      @studio = Studio.find(current_user.active_role.resource_id)
      @search = User.search(params[:search])
    elsif current_user.active_role.name == "professional"
        @search = current_user.profile.students.search(params[:search])
    end
    @students = Profile.all   # load all matching records  
  end
    
  def show
      
  end
  
  def search
    @payment = nil
    @active = nil
    @student = nil

    if params[:resource_type] == "Studio"
      object = Studio.find(params[:resource_id])
    elsif params[:resource_type] == "User"
      object = User.find(params[:resource_id])
    end

    @search = Profile.search(params[:search])
    @result = @search.first   # load all matching records

    if !@result.nil?
      @student = object.students.where(:profile_id => @result.id).first
      @student_present = @student.present?
      @payment = @result.customer.present?
      if @result.customer.present? && @result.customer.stripe_customer_token.present?
        @active = @result.active_membership(object)
        @membership = @result.find_purchased(Membership).first
      end
    end
      
    @profile_present = @result.present?
    respond_to do |format|
      format.js
    end
  end

end
