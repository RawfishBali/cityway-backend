class Admin::PlacesController < Admin::BaseController
  before_action :set_admin_place, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource param_method: :admin_place_params

  # GET /admin/places
  # GET /admin/places.json
  def index
    @admin_places = City.find(session[:current_city_id]).discover.places.where(place_type: Place.place_types[params[:place_type]]).page(params[:page]).per(10)
  end

  # GET /admin/places/1
  # GET /admin/places/1.json
  def show
  end

  # GET /admin/places/new
  def new
    @admin_place = Place.new
    @place_type = params[:place_type]
  end

  # GET /admin/places/1/edit
  def edit
  end

  # POST /admin/places
  # POST /admin/places.json
  def create
    @admin_place = City.find(session[:current_city_id]).discover.places.new(admin_place_params)
    @place_type = params[:place][:place_type]
    italian_type = { monument: 'Monumenti', library: 'Bibblioteche', theater: 'Teatri', museum: 'Musei', cinema: 'Cinema' }
    respond_to do |format|
      if @admin_place.save
        format.html { redirect_to session['previous_url'] ||  admin_places_url(place_type:@admin_place.place_type), notice: "#{italian_type[@place_type.to_sym]} è stato creato con successo." }
        format.json { render :show, status: :created, location: @admin_place }
      else
        format.html { render :new }
        format.json { render json: @admin_place.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/places/1
  # PATCH/PUT /admin/places/1.json
  def update
    respond_to do |format|
      italian_type = { monument: 'Monumenti', library: 'Bibblioteche', theater: 'Teatri', museum: 'Musei', cinema: 'Cinema' }
      if @admin_place.update(admin_place_params)
        format.html { redirect_to session['previous_url'] ||  admin_places_url(place_type:@admin_place.place_type), notice: "#{italian_type[@place_type.to_sym]} è stato aggiornato con successo." }
        format.json { render :show, status: :ok, location: @admin_place }
      else
        format.html { render :edit }
        format.json { render json: @admin_place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/places/1
  # DELETE /admin/places/1.json
  def destroy
    @admin_place.destroy
    italian_type = { monument: 'Monumenti', library: 'Bibblioteche', theater: 'Teatri', museum: 'Musei', cinema: 'Cinema' }
    respond_to do |format|
      format.html { redirect_to session['previous_url'] ||  admin_places_url, notice: "#{italian_type[@place_type.to_sym]} cancellata con successo!." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_place
      @admin_place = Place.find(params[:id])
      @place_type = @admin_place.place_type
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_place_params
      params.require(:place).permit(:name, :address, :description, :website,:place_type, :email, :facebook, :instagram, :twitter, :google_plus, :phone, :phone_1, :phone_2, :external_link, :support_disabilities, business_hours_attributes: [:id, :morning_open_time, :morning_close_time, :evening_open_time,
        :evening_close_time, :day, :_destroy] , photos_attributes: [:id, :picture,:is_primary,:position,:_destroy])
    end
end
