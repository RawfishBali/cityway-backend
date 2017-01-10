class Admin::ParksController < Admin::BaseController
  before_action :set_admin_park, only: [:show, :edit, :update, :destroy]

  # GET /admin/parks
  # GET /admin/parks.json
  def index
    @admin_parks = City.find(session[:current_city_id]).around.parks.page(params[:page]).per(10)
  end

  # GET /admin/parks/1
  # GET /admin/parks/1.json
  def show
  end

  # GET /admin/parks/new
  def new
    @admin_park = Park.new
    @around_id = City.find(session[:current_city_id]).around.id
  end

  # GET /admin/parks/1/edit
  def edit
  end

  # POST /admin/parks
  # POST /admin/parks.json
  def create
    @admin_park = Park.new(admin_park_params)

    respond_to do |format|
      if @admin_park.save
        format.html { redirect_to session['previous_url'] ||  admin_parks_path, notice: 'Parchi è stato creato con successo.' }
        format.json { render :show, status: :created, location: @admin_park }
      else
        format.html { render :new }
        format.json { render json: @admin_park.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/parks/1
  # PATCH/PUT /admin/parks/1.json
  def update
    respond_to do |format|
      if @admin_park.update(admin_park_params)
        format.html { redirect_to session['previous_url'] ||  admin_parks_path, notice: 'Parchi è stato aggiornato con successo.' }
        format.json { render :show, status: :ok, location: @admin_park }
      else
        format.html { render :edit }
        format.json { render json: @admin_park.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/parks/1
  # DELETE /admin/parks/1.json
  def destroy
    @admin_park.destroy
    respond_to do |format|
      format.html { redirect_to session['previous_url'] ||  admin_parks_path, notice: 'Parchi cancellata con successo!.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_park
      @around_id = City.find(session[:current_city_id]).around.id
      @admin_park = Park.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_park_params
      params.require(:park).permit(:name, :address, :description, :around_id, :support_disabilities, business_hours_attributes: [:id, :morning_open_time, :morning_close_time, :evening_open_time,
        :evening_close_time, :day, :_destroy], photos_attributes: [:id, :picture,:is_primary,:position,:_destroy])
    end
end
