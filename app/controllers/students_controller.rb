class StudentsController < ApplicationController
  
  def index
    @object = current_user.active_role.resource
    @search = @object.students.search(params[:search])

    @students = @search.all   # load all matching records  
  end
    
  def show

  end
  
  def search
    @payment = nil
    @active = nil
    @student = nil

    if params[:resource_type].present? && params[:resource_id].present?
      object = params[:resource_type].constantize.find(params[:resource_id])
    end

    @search = Profile.search(params[:search])
    @result = @search.first   # load all matching records

    if !@result.nil?
      @students = object.students
      @student = @students.where(:id => @result.id)
      @student_present = @student.present?
      @payment = @result.customer.present?
      if @result.customer.present? && @result.customer.stripe_customer_token.present?
        @active = @result.active_membership(object)
        @membership = @result.find_purchased(object, Membership).first
      end
    end
      
    @profile_present = @result.present?
    d
    respond_to do |format|
      format.js
    end
  end

  def create
    @search = Profile.search(params[:search])
    @result = @search.first   # load all matching records

    if !@result.nil?
      @student = Student.create!(:profile_id => @result.id, :resource_id => params[:resource_id], :signed_waiver => true, :resource_type => params[:resource_type])
      redirect_to :back
    else
      format.js
    end
  end


end
