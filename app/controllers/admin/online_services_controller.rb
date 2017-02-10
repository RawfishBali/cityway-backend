class Admin::OnlineServicesController < Admin::BaseController
  before_action :set_admin_online_service, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /admin/online_services
  # GET /admin/online_services.json
  def index
    @admin_online_services = City.find(session[:current_city_id]).commonplace.online_services.page(params[:page]).per(10)
  end

  # GET /admin/online_services/1
  # GET /admin/online_services/1.json
  def show
  end

  # GET /admin/online_services/new
  def new
    @commonplace_id = City.find(session[:current_city_id]).commonplace.id
    @admin_online_service = OnlineService.new
  end

  # GET /admin/online_services/1/edit
  def edit
  end

  # POST /admin/online_services
  # POST /admin/online_services.json
  def create
    @admin_online_service = City.find(session[:current_city_id]).commonplace.online_services.new(admin_online_service_params)
    @commonplace_id = City.find(session[:current_city_id]).commonplace.id
    respond_to do |format|
      if @admin_online_service.save
        format.html { redirect_to session['previous_url'] || admin_online_services_url, notice: 'Servizi Online è stato creato con successo.' }
        format.json { render :show, status: :created, location: @admin_online_service }
      else
        format.html { render :new }
        format.json { render json: @admin_online_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/online_services/1
  # PATCH/PUT /admin/online_services/1.json
  def update
    respond_to do |format|
      if @admin_online_service.update(admin_online_service_params)
        format.html { redirect_to session['previous_url'] ||  admin_online_services_url, notice: 'Servizi Online è stato aggiornato con successo.' }
        format.json { render :show, status: :ok, location: @admin_online_service }
      else
        format.html { render :edit }
        format.json { render json: @admin_online_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/online_services/1
  # DELETE /admin/online_services/1.json
  def destroy
    @admin_online_service.destroy
    respond_to do |format|
      format.html { redirect_to admin_online_services_url, notice: 'Servizi Online cancellata con successo!.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_online_service
      @admin_online_service = OnlineService.find(params[:id])
      @commonplace_id = @admin_online_service.commonplace.id
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_online_service_params
      params.require(:online_service).permit(:name, :url)
    end
end
