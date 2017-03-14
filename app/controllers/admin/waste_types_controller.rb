class Admin::WasteTypesController < Admin::BaseController
  before_action :set_admin_waste_type, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource param_method: :admin_waste_type_params

  # GET /admin/waste_types
  # GET /admin/waste_types.json
  def index
    @admin_waste_types = WasteType.all.page(params[:page])
  end

  # GET /admin/waste_types/1
  # GET /admin/waste_types/1.json
  def show
  end

  # GET /admin/waste_types/new
  def new
    @admin_waste_type = WasteType.new
  end

  # GET /admin/waste_types/1/edit
  def edit
  end

  # POST /admin/waste_types
  # POST /admin/waste_types.json
  def create
    @admin_waste_type = WasteType.new(admin_waste_type_params)

    respond_to do |format|
      if @admin_waste_type.save
        format.html { redirect_to session['previous_url'] || admin_waste_types_url, notice: 'Waste type è stato creato con successo.' }
        format.json { render :show, status: :created, location: @admin_waste_type }
      else
        format.html { render :new }
        format.json { render json: @admin_waste_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/waste_types/1
  # PATCH/PUT /admin/waste_types/1.json
  def update
    respond_to do |format|
      if @admin_waste_type.update(admin_waste_type_params)
        format.html { redirect_to session['previous_url'] || admin_waste_types_url, notice: 'Waste type è stato aggiornato con successo.' }
        format.json { render :show, status: :ok, location: @admin_waste_type }
      else
        format.html { render :edit }
        format.json { render json: @admin_waste_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/waste_types/1
  # DELETE /admin/waste_types/1.json
  def destroy
    @admin_waste_type.destroy
    respond_to do |format|
      format.html { redirect_to session['previous_url'] || admin_waste_types_url, notice: 'Waste type cancellata con successo!.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_waste_type
      @admin_waste_type = WasteType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_waste_type_params
      params.require(:waste_type).permit(:name, :icon)
    end
end
