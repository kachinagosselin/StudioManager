class ServicesController < ApplicationController
	def index
	end

	def create
        @service = Service.new(params[:service])

        respond_to do |format|
            if @service.save
                format.html { redirect_to products_path }
                format.js
            else
                format.html { redirect_to products_path, alert: 'Service was unsuccessfully created.' }
                format.json { render json: @message.errors, status: :unprocessable_entity }
            end 
        end
	end

	def update
		@service = Service.find(params[:id])

        respond_to do |format|
            if @service.update_attributes(params[:service])
                format.html { redirect_to products_path }
                format.json { head :no_content }
            else
                format.html { redirect_to products_path, alert: 'Service was upsuccessfully updated.' }
                format.json { render json: @message.errors, status: :unprocessable_entity }
            end
        end
	end

    def purchase
    end
    
	def destroy
	end
end
