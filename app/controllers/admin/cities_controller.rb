class Admin::CitiesController < Admin::BaseController
  before_action :set_city, except: [:index, :new, :create]

  def index
    @city = City.new
    @around = @city.build_around
    @utility = @city.build_utility
    @commonplace = @city.build_commonplace
    @discover = @city.build_discover
    @cities = City.all.order('Name ASC').page(20).page params[:page]
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @city = City.new
  end

  # GET /posts/1/edit
  def edit
    set_city
  end

  # POST /posts
  # POST /posts.json
  def create
    @city = City.new(city_params)

    respond_to do |format|
      if @city.save
        format.html { redirect_to admin_cities_path, notice: 'City was successfully created.' }
        format.json { render :show, status: :created, location: @city }
      else
        format.html { redirect_to :back, notice: @city.errors.full_messages }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @city.update(city_params)
        format.html { redirect_to admin_cities_path, notice: 'City was successfully updated.' }
        format.json { render :show, status: :ok, location: @city }
      else
        format.html { redirect_to edit_admin_city_path(@city), notice: @city.errors.full_messages }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @city.destroy
    respond_to do |format|
      format.html { redirect_to admin_cities_url, notice: 'City was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_city
      @city = City.find(params[:id])
      @around = @city.around || @city.build_around
      @utility = @city.utility || @city.build_utility
      @commonplace = @city.commonplace || @city.build_commonplace
      @discover = @city.discover || @city.build_discover
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def city_params
      params.require(:city).permit(:name, :latitude, :longitude, :description, :photo, discover_attributes: [:id , :photo, :city_id], around_attributes: [:id , :photo, :city_id], commonplace_attributes: [:id , :photo, :icon, :city_id], utility_attributes: [:id , :photo, :city_id])
    end
end
