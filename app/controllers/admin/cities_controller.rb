class Admin::CitiesController < Admin::BaseController
  before_action :set_city, except: [:index, :new, :create]

  def index
    @cities = City.all.order('Name ASC').page(20).page params[:page]
  end


  def show
  end

  def new
    @city = City.new
    @around = @city.build_around
    @utility = @city.build_utility
    @commonplace = @city.build_commonplace
    @discover = @city.build_discover
  end

  def edit
    set_city
  end

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

  def update
    respond_to do |format|
      # image_json =  JSON.parse(params["city"]["photo"]["_values"].gsub("'",'"').gsub('=>',':'))
      # puts "-------------------------"
      # puts image_json["data"]
      # puts "-------------------------"
      #
      # puts "-------------------------"
      # params["city"]["photo"] = image_json["data"]
      if @city.update(city_params)
        format.html { redirect_to edit_admin_city_path(@city), notice: 'City was successfully updated.' }
        format.json { render :show, status: :ok, location: @city }
      else
        format.html { redirect_to edit_admin_city_path(@city), notice: @city.errors.full_messages }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @city.destroy
    respond_to do |format|
      format.html { redirect_to admin_cities_url, notice: 'City was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_city
      @city = City.find(params[:id])
      session[:current_city_id] = @city.id
      @selected_city = City.find(session[:current_city_id])
      @around = @city.around
      @utility = @city.utility
      @commonplace = @city.commonplace
      @discover = @city.discover
    end

    def city_params
      params.require(:city).permit!
    end
end
