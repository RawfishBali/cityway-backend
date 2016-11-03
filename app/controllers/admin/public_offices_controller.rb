class Admin::PublicOfficesController < Admin::BaseController
  before_action :set_admin_public_office, only: [:show, :edit, :update, :destroy]

  # GET /admin/public_offices
  # GET /admin/public_offices.json
  def index
    @admin_public_offices =  City.find(session[:current_city_id]).commonplace.public_offices.page(params[:page]).per(10)
  end

  # GET /admin/public_offices/1
  # GET /admin/public_offices/1.json
  def show
  end

  # GET /admin/public_offices/new
  def new
    @commonplace_id = City.find(session[:current_city_id]).commonplace.id
    @admin_public_office = PublicOffice.new
  end

  # GET /admin/public_offices/1/edit
  def edit
  end

  # POST /admin/public_offices
  # POST /admin/public_offices.json
  def create
    @admin_public_office = PublicOffice.new(admin_public_office_params)

    respond_to do |format|
      if @admin_public_office.save
        format.html { redirect_to session['previous_url'] || admin_public_offices_url, notice: 'Public office was successfully created.' }
        format.json { render :show, status: :created, location: @admin_public_office }
      else
        format.html { render :new }
        format.json { render json: @admin_public_office.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/public_offices/1
  # PATCH/PUT /admin/public_offices/1.json
  def update
    respond_to do |format|
      if @admin_public_office.update(admin_public_office_params)
        format.html { redirect_to session['previous_url'] || admin_public_offices_url, notice: 'Public office was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_public_office }
      else
        format.html { render :edit }
        format.json { render json: @admin_public_office.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/public_offices/1
  # DELETE /admin/public_offices/1.json
  def destroy
    @admin_public_office.destroy
    respond_to do |format|
      format.html { redirect_to session['previous_url'] || admin_public_offices_url, notice: 'Public office was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_public_office
      @admin_public_office = PublicOffice.find(params[:id])
      @commonplace_id = @admin_public_office.commonplace.id
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_public_office_params
      params.require(:public_office).permit(:name, :address, :description, :commonplace_id, :website, :fax, :phone, business_hours_attributes: [:id, :morning_open_time, :morning_close_time, :evening_open_time,
        :evening_close_time, :day, :_destroy] , photos_attributes: [:id, :picture,:is_primary,:position,:_destroy])
    end
end
