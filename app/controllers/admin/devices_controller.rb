class Admin::DevicesController < Admin::BaseController
  before_action :set_admin_device, only: [:show, :edit, :update, :destroy]

  # GET /admin/devices
  # GET /admin/devices.json
  def index
    @admin_devices = City.find(session[:current_city_id]).utility.devices.where(device_type: Device.device_types[params[:device_type]]).page(params[:page]).per(10)
  end

  # GET /admin/devices/1
  # GET /admin/devices/1.json
  def show
  end

  # GET /admin/devices/new
  def new
    @utility_id = City.find(session[:current_city_id]).utility.id
    @admin_device = Device.new
    @device_type = Device.device_types[params[:device_type]]
  end

  # GET /admin/devices/1/edit
  def edit
  end

  # POST /admin/devices
  # POST /admin/devices.json
  def create
    @admin_device = Device.new(admin_device_params)
    @utility_id = City.find(session[:current_city_id]).utility.id
    @device_type = Device.device_types[params[:device_type]]
    respond_to do |format|
      if @admin_device.save
        format.html { redirect_to session['previous_url'] || admin_devices_url(device_type: @admin_device.device_type), notice: 'Device è stato creato con successo.' }
        format.json { render :show, status: :created, location: @admin_device }
      else
        format.html { render :new }
        format.json { render json: @admin_device.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/devices/1
  # PATCH/PUT /admin/devices/1.json
  def update
    respond_to do |format|
      if @admin_device.update(admin_device_params)
        format.html { redirect_to session['previous_url'] || admin_devices_url(device_type: @admin_device.device_type), notice: 'Device è stato aggiornato con successo.' }
        format.json { render :show, status: :ok, location: @admin_device }
      else
        format.html { render :edit }
        format.json { render json: @admin_device.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/devices/1
  # DELETE /admin/devices/1.json
  def destroy
    @admin_device.destroy
    respond_to do |format|
      format.html { redirect_to session['previous_url'] || admin_devices_url, notice: 'Device è stato distrutto con successo.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_device
      @utility_id = City.find(session[:current_city_id]).utility.id
      @admin_device = Device.find(params[:id])
      @device_type = @admin_device.device_type
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_device_params
      params.require(:device).permit(:name, :external_url, :utility_id,:address, :device_type)
    end
end
