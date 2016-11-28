class Admin::UtilityNumbersController < Admin::BaseController
  before_action :set_admin_utility_number, only: [:show, :edit, :update, :destroy]

  # GET /admin/utility_numbers
  # GET /admin/utility_numbers.json
  def index
    @admin_utility_numbers = City.find(session[:current_city_id]).utility.utility_numbers.page(params[:page]).per(10)
  end

  # GET /admin/utility_numbers/1
  # GET /admin/utility_numbers/1.json
  def show
  end

  # GET /admin/utility_numbers/new
  def new
    @utility_id = City.find(session[:current_city_id]).utility.id
    @admin_utility_number = UtilityNumber.new
  end

  # GET /admin/utility_numbers/1/edit
  def edit
  end

  # POST /admin/utility_numbers
  # POST /admin/utility_numbers.json
  def create
    @admin_utility_number = UtilityNumber.new(admin_utility_number_params)
    @utility_id = City.find(session[:current_city_id]).utility.id
    respond_to do |format|
      if @admin_utility_number.save
        format.html { redirect_to session['previous_url'] || admin_utility_numbers_url, notice: 'Numeri utili è stato creato con successo.' }
        format.json { render :show, status: :created, location: @admin_utility_number }
      else
        format.html { render :new }
        format.json { render json: @admin_utility_number.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/utility_numbers/1
  # PATCH/PUT /admin/utility_numbers/1.json
  def update
    respond_to do |format|
      if @admin_utility_number.update(admin_utility_number_params)
        format.html { redirect_to session['previous_url'] || admin_utility_numbers_url, notice: 'Numeri utili è stato aggiornato con successo.' }
        format.json { render :show, status: :ok, location: @admin_utility_number }
      else
        format.html { render :edit }
        format.json { render json: @admin_utility_number.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/utility_numbers/1
  # DELETE /admin/utility_numbers/1.json
  def destroy
    @admin_utility_number.destroy
    respond_to do |format|
      format.html { redirect_to session['previous_url'] || admin_utility_numbers_url, notice: 'Numeri utili cancellata con successo!.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_utility_number
      @admin_utility_number = UtilityNumber.find(params[:id])
      @utility_id = City.find(session[:current_city_id]).utility.id
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_utility_number_params
      params.require(:utility_number).permit(:name, :national_number, :local_number, :utility_id,:address)
    end
end
