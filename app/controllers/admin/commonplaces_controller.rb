class Admin::CommonplacesController < ApplicationController
  before_action :set_commonplace, except: [:index, :new, :create]

  def update
    respond_to do |format|
      if @commonplace.update(commonplace_params)
        format.html { redirect_to admin_commonplaces_path, notice: 'Commune was successfully updated.' }
        format.json { render :show, status: :ok, location: @commonplace }
      else
        format.html { redirect_to admin_commonplaces_path, notice: @commonplace.errors.full_messages }
        format.json { render json: @commonplace.errors, status: :unprocessable_entity }
      end
    end
  end


  private
  def set_commonplace
    @commonplace = Commonplace.find(params[:id])
  end

    def commonplace_params
      params.require(:commonplace).permit(:photo, :icon, :city_id)
    end
end
