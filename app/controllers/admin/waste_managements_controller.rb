class Admin::WasteManagementsController < Admin::BaseController
  before_action :set_admin_waste_management, only: [:show, :edit, :update, :destroy]

  # GET /admin/waste_managements
  # GET /admin/waste_managements.json
  def index
    @admin_waste_managements = City.find(session[:current_city_id]).utility.waste_managements.page(params[:page])
  end

  # GET /admin/waste_managements/1
  # GET /admin/waste_managements/1.json
  def show
  end

  # GET /admin/waste_managements/new
  def new
    @admin_waste_management = WasteManagement.new
  end

  # GET /admin/waste_managements/1/edit
  def edit
  end

  # POST /admin/waste_managements
  # POST /admin/waste_managements.json
  def create
    @admin_waste_management = City.find(session[:current_city_id]).utility.waste_managements.new(admin_waste_management_params)

    respond_to do |format|
      if @admin_waste_management.save
        format.html { redirect_to session['previous_url'] || admin_waste_managements_url, notice: 'Waste management was successfully created.' }
        format.json { render :show, status: :created, location: @admin_waste_management }
      else
        format.html { render :new }
        format.json { render json: @admin_waste_management.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/waste_managements/1
  # PATCH/PUT /admin/waste_managements/1.json
  def update
    respond_to do |format|
      if @admin_waste_management.update(admin_waste_management_params)
        format.html { redirect_to session['previous_url'] || admin_waste_managements_url, notice: 'Waste management was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_waste_management }
      else
        format.html { render :edit }
        format.json { render json: @admin_waste_management.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/waste_managements/1
  # DELETE /admin/waste_managements/1.json
  def destroy
    @admin_waste_management.destroy
    respond_to do |format|
      format.html { redirect_to session['previous_url'] || admin_waste_managements_url, notice: 'Waste management was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_waste_management
      @admin_waste_management = WasteManagement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_waste_management_params
      params.require(:waste_management).permit(:name, :address, :email, :phone, :website, :description, :is_domestic, waste_pickup_schedules_attributes: [:id, :day, waste_types: [] ])
    end
end
