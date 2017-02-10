class Admin::ParkingLotsController < Admin::BaseController
  before_action :set_admin_parking_lot, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /admin/parking_lots
  # GET /admin/parking_lots.json
  def index
    @admin_parking_lots =
    City.find(session[:current_city_id]).utility.parking_lots.page(params[:page]).per(10)
  end

  # GET /admin/parking_lots/1
  # GET /admin/parking_lots/1.json
  def show
  end

  # GET /admin/parking_lots/new
  def new
    @utility_id = City.find(session[:current_city_id]).utility.id
    @admin_parking_lot = ParkingLot.new
  end

  # GET /admin/parking_lots/1/edit
  def edit
  end

  # POST /admin/parking_lots
  # POST /admin/parking_lots.json
  def create
    @admin_parking_lot = City.find(session[:current_city_id]).utility.parking_lots.new(admin_parking_lot_params)

    respond_to do |format|
      if @admin_parking_lot.save
        format.html { redirect_to admin_parking_lots_url, notice: 'Parking lot was successfully created.' }
        format.json { render :show, status: :created, location: @admin_parking_lot }
      else
        format.html { render :new }
        format.json { render json: @admin_parking_lot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/parking_lots/1
  # PATCH/PUT /admin/parking_lots/1.json
  def update
    respond_to do |format|
      if @admin_parking_lot.update(admin_parking_lot_params)
        format.html { redirect_to admin_parking_lots_url, notice: 'Parking lot was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_parking_lot }
      else
        format.html { render :edit }
        format.json { render json: @admin_parking_lot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/parking_lots/1
  # DELETE /admin/parking_lots/1.json
  def destroy
    @admin_parking_lot.destroy
    respond_to do |format|
      format.html { redirect_to admin_parking_lots_url, notice: 'Parking lot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_parking_lot
      @utility_id = City.find(session[:current_city_id]).utility.id
      @admin_parking_lot = ParkingLot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_parking_lot_params
      params.require(:parking_lot).permit!
    end
end
