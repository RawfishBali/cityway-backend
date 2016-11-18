class Admin::ItinerariesController < Admin::BaseController
  before_action :set_admin_itinerary, only: [:show, :edit, :update, :destroy]

  # GET /admin/itineraries
  # GET /admin/itineraries.json
  def index
    @admin_itineraries= City.find(session[:current_city_id]).discover.itineraries.page(params[:page]).per(10)
  end

  # GET /admin/itineraries/1
  # GET /admin/itineraries/1.json
  def show
  end

  # GET /admin/itineraries/new
  def new
    @discover_id = City.find(session[:current_city_id]).discover.id
    @admin_itinerary = Itinerary.new
  end

  # GET /admin/itineraries/1/edit
  def edit
  end

  # POST /admin/itineraries
  # POST /admin/itineraries.json
  def create
    @admin_itinerary = Itinerary.new(admin_itinerary_params)

    respond_to do |format|
      if @admin_itinerary.save
        format.html { redirect_to session['previous_url'] || admin_itineraries_url, notice: 'Itinerari è stato creato con successo.' }
        format.json { render :show, status: :created, location: @admin_itinerary }
      else
        format.html { render :new }
        format.json { render json: @admin_itinerary.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/itineraries/1
  # PATCH/PUT /admin/itineraries/1.json
  def update
    respond_to do |format|
      if @admin_itinerary.update(admin_itinerary_params)
        format.html { redirect_to session['previous_url'] || admin_itineraries_url, notice: 'Itinerari è stato aggiornato con successo.' }
        format.json { render :show, status: :ok, location: @admin_itinerary }
      else
        format.html { render :edit }
        format.json { render json: @admin_itinerary.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/itineraries/1
  # DELETE /admin/itineraries/1.json
  def destroy
    @admin_itinerary.destroy
    respond_to do |format|
      format.html { redirect_to admin_itineraries_url, notice: 'Itinerari è stato distrutto con successo.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_itinerary
      @admin_itinerary = Itinerary.find(params[:id])
      @discover_id = @admin_itinerary.discover.id
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_itinerary_params
      params.require(:itinerary).permit(:name, :description, :visiting_time, :discover_id,photos_attributes: [:id, :picture, :position, :is_primary, :_destroy], steps_attributes: [:id, :address, :_destroy])
    end
end
