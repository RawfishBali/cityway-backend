class Admin::CitiesController < Admin::BaseController
  before_action :set_city, except: [:index, :new, :create]
  load_and_authorize_resource
  skip_authorize_resource :only => :edit

  def index
    if current_admin.has_role? :admin_merchant
      @cities = City.where('id in (?)', current_admin.merchants.map(&:city_id)).order('Name ASC').page(20).page params[:page]
    else
      @cities = City.all.order('Name ASC').page(20).page params[:page]
    end
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
    return redirect_to admin_merchants_path if current_admin.has_role? :merchant_admin
  end

  def create
    @city = City.new(city_params)

    respond_to do |format|
      if @city.save
        session[:current_city_id] = @city.id
        @selected_city = @city
        @around = @city.around
        @utility = @city.utility
        @commonplace = @city.commonplace
        @discover = @city.discover
        format.html { redirect_to edit_admin_city_path(@city), notice: 'Città è stato creato con successo.' }
        format.json { render :show, status: :created, location: @city }
      else
        format.html { redirect_to :back, notice: @city.errors.full_messages }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|

      if @city.update(city_params)
        format.html { redirect_to edit_admin_city_path(@city), notice: 'Città è stato aggiornato con successo.' }
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
      format.html { redirect_to root_path, notice: 'Città cancellata con successo!.' }
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
