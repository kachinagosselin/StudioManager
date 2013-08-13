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
        
        respond_to do |format|
            if @studio.save
                format.html { redirect_to root_path(), notice: 'studio was successfully created.' }
                format.json { head :no_content }
                else
                format.html { render :action => 'new', alert: 'studio was unsuccessfully created.' }
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
                format.html { redirect_to studio_path(@studio), notice: 'studio was successfully updated.' }
                format.json { head :no_content }
                else
                format.html { render action: "edit" }
                format.json { render json: @message.errors, status: :unprocessable_entity }
            end
        end
    end
    
    def instructors
        @studio = Account.where(:user_id == current_user.id).first.studio
        @instructors = User.with_role(:instructor, @studio)
    end 

    def students
        @studio = Account.where(:user_id == current_user.id).first.studio
        @students = User.with_role(:student, @studio)
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
