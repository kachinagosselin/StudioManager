class StudiosController < ApplicationController

    def index
        @studios = Studio.all
    end
    
    def show
        @studio = Studio.find(params[:id])
    end
    
    def new
        @studio = Studio.new
    end
    
    def create
        @studio = Studio.create(params[:studio])
        @user = current_user
        @account = Account.where(:user_id => current_user.id).first
        @studio.account_id = @account.id
        
        respond_to do |format|
            if @studio.save
                @user.add_role :owner
                format.html { redirect_to :back, notice: 'Studio was successfully created.' }
                format.json { head :no_content }
                else
                format.html { render :action => 'new', alert: 'Studio was unsuccessfully created.' }
                format.json { render json: @message.errors, status: :unprocessable_entity }
            end 
        end
    end
    
    def edit
        @studio = Studio.find(params[:id])
    end
    
    def update
        @studio = Studio.find(params[:id])
        
        respond_to do |format|
            if @studio.update_attributes(params[:studio])
                format.html { redirect_to :back, notice: 'Studio was successfully updated.' }
                format.json { head :no_content }
                else
                format.html { render action: "edit" }
                format.json { render json: @message.errors, status: :unprocessable_entity }
            end
        end
    end
    
    def instructors
        @studio = Studio.find(params[:id])
        @search = @studio.staff.search(params[:search])
        @instructors = @search.all   # load all matching records
        
        @available_instructors = User.joins(:profile).where('is_certified = ?',  true)
        @search_database = @available_instructors.search(params[:search])
        @instructors_database = @search_database.all   # load all matching records
    end 

    def instructors_database
        @studio = Studio.find(params[:id])
 
    end 
    
    def students
        @studio = Studio.find(params[:id])
        @search = @studio.users.search(params[:search])
        @students = @search.all   # load all matching records
    end 
    
    def register
    end
    
    def invoice
    end
    
    def details  
        @studio = Studio.find(params[:id])
        
        @json = Studio.all.to_gmaps4rails do |studio, marker|
            marker.json({ :id => studio.id })
        end
        
        respond_to do | format |  
            format.js {render :layout => false}  
        end
    end
    

    def destroy
        @studio = Studio.find(params[:id])
        @studio.destroy
        redirect_to :back
    end
end
