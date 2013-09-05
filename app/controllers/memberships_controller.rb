class MembershipsController < ApplicationController
        
        def index
            @studio = Studio.find(params[:studio_id])
            @memberships = @studio.memberships.find(:all)

            respond_to do |format|
                format.html # index.html.erb
                format.json { render json: @memberships }
            end
        end
        
        def create
            @studio = Studio.find(params[:studio_id])
            @membership = Membership.new(params[:membership])
            @membership.studio_id = @studio.id
            respond_to do |format|
                if @membership.save
                    format.html { redirect_to studio_memberships_path(@studio) }
                    format.json { head :no_content }
                    else
                    format.html { render :action => 'new', alert: 'Membership was unsuccessfully created.' }
                    format.json { render json: @message.errors, status: :unprocessable_entity }
                end 
            end
        end
    
    
    def edit
        @studio = Studio.find(params[:studio_id])
        @membership = Membership.find(params[:id])
    end
    
    
    def update
        @studio = Studio.find(params[:studio_id])
        @membership = Membership.find(params[:id])
        
        respond_to do |format|
            if @mebership.update_attributes(params[:event])
                format.html { redirect_to studio_memberships_path(@studio), notice: 'Membership was successfully updated.' }
                format.json { head :no_content }
                else
                format.html { render action: "edit" }
                format.json { render json: @message.errors, status: :unprocessable_entity }
            end
        end
    end
        
        def destroy
            @membership = Membership.find(params[:id])
            @membership.destroy
            redirect_to :back
        end
    end
