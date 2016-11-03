class Admin::VehiclesController < Admin::BaseController
  before_action :set_admin_vehicle, only: [:show, :edit, :update, :destroy]

  # GET /admin/vehicles
  # GET /admin/vehicles.json
  def index
    @admin_vehicles = City.find(session[:current_city_id]).utility.vehicles.where(vehicle_type: Vehicle.vehicle_types[params[:vehicle_type]]).page(params[:page]).per(10)
  end

  # GET /admin/vehicles/1
  # GET /admin/vehicles/1.json
  def show
  end

  # GET /admin/vehicles/new
  def new
    @admin_vehicle = City.find(session[:current_city_id]).utility.vehicles.new
    @vehicle_type = params[:vehicle_type]
  end

  # GET /admin/vehicles/1/edit
  def edit
  end

  # POST /admin/vehicles
  # POST /admin/vehicles.json
  def create
    @admin_vehicle = City.find(session[:current_city_id]).utility.vehicles.new(admin_vehicle_params)
    @vehicle_type = Vehicle.vehicle_types[params[:vehicle_type]]
    respond_to do |format|
      if @admin_vehicle.save
        format.html { redirect_to session['previous_url'] || admin_vehicles_url(vehicle_type: @admin_vehicle.vehicle_type), notice: 'Vehicle was successfully created.' }
        format.json { render :show, status: :created, location: @admin_vehicle }
      else
        format.html { render :new }
        format.json { render json: @admin_vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/vehicles/1
  # PATCH/PUT /admin/vehicles/1.json
  def update
    respond_to do |format|
      if @admin_vehicle.update(admin_vehicle_params)
        format.html { redirect_to session['previous_url'] || admin_vehicles_url(vehicle_type: @admin_vehicle.vehicle_type), notice: 'Vehicle was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_vehicle }
      else
        format.html { render :edit }
        format.json { render json: @admin_vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/vehicles/1
  # DELETE /admin/vehicles/1.json
  def destroy
    @admin_vehicle.destroy
    respond_to do |format|
      format.html { redirect_to session['previous_url'] || admin_vehicles_url, notice: 'Vehicle was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_vehicle
      @admin_vehicle = Vehicle.find(params[:id])
      @vehicle_type = @admin_vehicle.vehicle_type
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_vehicle_params
      params.require(:vehicle).permit(:name, :address, :utility_id,:phone_0, :phone_1, :total_parking_lot, :available_parking_lot, :vehicle_type, :web, :email)
    end
end
