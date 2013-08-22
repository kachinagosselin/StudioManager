class MembershipsController < ApplicationController
        
        def index
            @studio = Studio.find(params[:studio_id])
            @memberships = @studio.memberships.find(:all)
            @membership = @studio.memberships.new
            puts 'index'
            respond_to do |format|
                format.html # index.html.erb
                format.json { render json: @memberships }
            end
        end
        
        def create
            @studio = Studio.find(params[:studio_id])
            @membership = Membership.new(params[:membership])
            @membership.studio_id = @studio.id
            puts 'create'
            respond_to do |format|
                if @membership.save
                    format.html { redirect_to studio_memberships_path(@studio), notice: 'Membership was successfully created.' }
                    format.json { head :no_content }
                    else
                    format.html { render :action => 'new', alert: 'Membership was unsuccessfully created.' }
                    format.json { render json: @message.errors, status: :unprocessable_entity }
                end 
            end
        end
        
        def destroy
            @studio = Studio.find(params[:studio_id])
            @membership = Membership.find(params[:id])
            @membership.destroy
            redirect_to studio_memberships_path(@studio)
        end
    end
