class PackagesController < ApplicationController

    def create
      @package = Package.new(params[:package])
      
      respond_to do |format|
          if @package.save
              format.html { redirect_to products_path }
              format.json { head :no_content }
              else
              format.html { redirect_to products_path, alert: 'Package was unsuccessfully created.' }
              format.json { render json: @message.errors, status: :unprocessable_entity }
          end 
      end
    end

    def update
        @package = Package.find(params[:id])

        respond_to do |format|
            if @package.update_attributes(params[:package])
                format.html { redirect_to products_path }
                format.json { head :no_content }
                else
                format.html { redirect_to products_path, alert: 'Package was upsuccessfully updated.' }
                format.json { render json: @message.errors, status: :unprocessable_entity }
            end
        end
    end
    
    def archive
        @package = Package.find(params[:id])
        
        if @package.expires_at.present?
            if @package.expires_at <= DateTime.now
                @package.update_attribute(:archived => true)
            end
        end
    end
    
    def destroy
        @package = Package.find(params[:id])
        redirect_to :back
    end
end
