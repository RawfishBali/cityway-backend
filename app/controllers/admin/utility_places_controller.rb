class Admin::UtilityPlacesController < Admin::BaseController
  before_action :set_admin_utility_place, only: [:show, :edit, :update, :destroy]

  # GET /admin/utility_places
  # GET /admin/utility_places.json
  def index
    @admin_utility_places = City.find(session[:current_city_id]).utility.utility_places.where(place_type: UtilityPlace.place_types[params[:place_type]]).page(params[:page]).per(10)
  end

  # GET /admin/utility_places/1
  # GET /admin/utility_places/1.json
  def show
  end

  # GET /admin/utility_places/new
  def new
    utility = City.find(session[:current_city_id]).utility
    @place_type = params[:place_type]
    @admin_utility_place = utility.utility_places.new
  end

  # GET /admin/utility_places/1/edit
  def edit
  end

  # POST /admin/utility_places
  # POST /admin/utility_places.json
  def create
    utility = City.find(session[:current_city_id]).utility
    @admin_utility_place = utility.utility_places.new(admin_utility_place_params)
    @place_type = @admin_utility_place.place_type
    respond_to do |format|
      if @admin_utility_place.save
        format.html { redirect_to admin_utility_places_url(place_type: @admin_utility_place.place_type), notice: 'Utility place was successfully created.' }
        format.json { render :show, status: :created, location: @admin_utility_place }
      else
        format.html { render :new }
        format.json { render json: @admin_utility_place.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/utility_places/1
  # PATCH/PUT /admin/utility_places/1.json
  def update
    respond_to do |format|
      if @admin_utility_place.update(admin_utility_place_params)
        format.html { redirect_to admin_utility_places_url(place_type: @admin_utility_place.place_type), notice: 'Utility place was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_utility_place }
      else
        format.html { render :edit }
        format.json { render json: @admin_utility_place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/utility_places/1
  # DELETE /admin/utility_places/1.json
  def destroy
    @admin_utility_place.destroy
    respond_to do |format|
      format.html { redirect_to admin_utility_places_url, notice: 'Utility place was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_utility_place
      @admin_utility_place = UtilityPlace.find(params[:id])
      @place_type = @admin_utility_place.place_type
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_utility_place_params
      params.require(:utility_place).permit(:name, :denomination, :description, :visitable_id, :visitable_type, :address, :email,:phone, :place_type, :is_public, :website, :commercial,  photos_attributes: [:id, :picture, :is_primary, :position,  :_destroy], business_hours_attributes: [:id, :morning_open_time, :morning_close_time, :evening_open_time,
        :evening_close_time, :day, :_destroy])
    end
end
