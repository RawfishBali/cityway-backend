class Admin::PublicTransportsController < Admin::BaseController
  before_action :set_admin_public_transport, only: [:show, :edit, :update, :destroy]

  # GET /admin/public_transports
  # GET /admin/public_transports.json
  def index
    @admin_public_transports = City.find(session[:current_city_id]).utility.public_transports.page(params[:page]).per(10)
  end

  # GET /admin/public_transports/1
  # GET /admin/public_transports/1.json
  def show
  end

  # GET /admin/public_transports/new
  def new
    @admin_public_transport = City.find(session[:current_city_id]).utility.public_transports.new
  end

  # GET /admin/public_transports/1/edit
  def edit
  end

  # POST /admin/public_transports
  # POST /admin/public_transports.json
  def create
    @admin_public_transport = City.find(session[:current_city_id]).utility.public_transports.new(admin_public_transport_params)

    respond_to do |format|
      if @admin_public_transport.save
        format.html { redirect_to session['previous_url'] || admin_public_transports_url, notice: 'Public transport è stato creato con successo.' }
        format.json { render :show, status: :created, location: @admin_public_transport }
      else
        format.html { render :new }
        format.json { render json: @admin_public_transport.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/public_transports/1
  # PATCH/PUT /admin/public_transports/1.json
  def update
    respond_to do |format|
      if @admin_public_transport.update(admin_public_transport_params)
        format.html { redirect_to session['previous_url'] || admin_public_transports_url, notice: 'Public transport è stato aggiornato con successo.' }
        format.json { render :show, status: :ok, location: @admin_public_transport }
      else
        format.html { render :edit }
        format.json { render json: @admin_public_transport.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/public_transports/1
  # DELETE /admin/public_transports/1.json
  def destroy
    @admin_public_transport.destroy
    respond_to do |format|
      format.html { redirect_to session['previous_url'] || admin_public_transports_url, notice: 'Public transport è stato distrutto con successo.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_public_transport
      @admin_public_transport = PublicTransport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_public_transport_params
      params.require(:public_transport).permit(:name, :attachment, :transport_type, paths_attributes: [:id, :path, :_destroy])
    end
end
