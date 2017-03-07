class Admin::CommonplacesController < Admin::BaseController
  before_action :set_commonplace, except: [:index, :new, :create]
  load_and_authorize_resource param_method: :commonplace_params

  def edit
  end

  def update
    respond_to do |format|
      if @commonplace.update(commonplace_params)
        format.html { redirect_to edit_admin_commonplace_path(@commonplace), notice: 'Commune è stato aggiornato con successo.' }
        format.json { render :show, status: :ok, location: @commonplace }
      else
        format.html { redirect_to edit_admin_commonplace_path, notice: @commonplace.errors.full_messages }
        format.json { render json: @commonplace.errors, status: :unprocessable_entity }
      end
    end
  end


  private
  def set_commonplace
    @commonplace = Commonplace.find(params[:id])
  end

    def commonplace_params
      params.require(:commonplace).permit!
      # (:photo, :city_id, :facebook, :instagram, :twitter, :google_plus,icon: {})
    end
end
