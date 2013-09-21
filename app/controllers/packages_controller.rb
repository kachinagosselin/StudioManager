class PackagesController < ApplicationController
  def new
  end

  def create
      @studio = Studio.find(params[:studio_id])
      @package = @studio.packages.new(params[:package])
      
      respond_to do |format|
          if @package.save
              format.html { redirect_to studio_products_path(@studio) }
              format.json { head :no_content }
              else
              format.html { redirect_to studio_products_path(@studio), alert: 'Package was unsuccessfully created.' }
              format.json { render json: @message.errors, status: :unprocessable_entity }
          end 
      end
  end

  def edit
  end

    def update
        @studio = Studio.find(params[:studio_id])
        @package = @studio.packages.find(params[:id])

        respond_to do |format|
            if @package.update_attributes(params[:package])
                format.html { redirect_to studio_products_path(@studio) }
                format.json { head :no_content }
                else
                format.html { redirect_to studio_products_path(@studio), alert: 'Package was upsuccessfully updated.' }
                format.json { render json: @message.errors, status: :unprocessable_entity }
            end
        end
    end
    
    def destroy
        @studio = Studio.find(params[:studio_id])
        @package = @studio.packages.find(params[:id])
        
        if @package.expires_at.present?
            if @package.expires_at <= DateTime.now
                @package.update_attribute(:archived => true)
            end
        end
        redirect_to :back
    end

  def purchase
  end
end
