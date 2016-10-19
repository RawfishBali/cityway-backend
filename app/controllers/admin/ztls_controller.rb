class Admin::ZtlsController < Admin::BaseController
  before_action :set_admin_ztl, only: [:show, :edit, :update, :destroy]

  # GET /admin/ztls
  # GET /admin/ztls.json
  def index
    @admin_ztls = City.find(session[:current_city_id]).utility.ztls.page(params[:page]).per(10)
  end

  # GET /admin/ztls/1
  # GET /admin/ztls/1.json
  def show
  end

  # GET /admin/ztls/new
  def new
    @admin_ztl = City.find(session[:current_city_id]).utility.ztls.new
  end

  # GET /admin/ztls/1/edit
  def edit
  end

  # POST /admin/ztls
  # POST /admin/ztls.json
  def create
    @admin_ztl = City.find(session[:current_city_id]).utility.ztls.new(admin_ztl_params)

    respond_to do |format|
      if @admin_ztl.save
        format.html { redirect_to admin_ztls_url, notice: 'Ztl was successfully created.' }
        format.json { render :show, status: :created, location: @admin_ztl }
      else
        format.html { render :new }
        format.json { render json: @admin_ztl.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/ztls/1
  # PATCH/PUT /admin/ztls/1.json
  def update
    respond_to do |format|
      if @admin_ztl.update(admin_ztl_params)
        format.html { redirect_to admin_ztls_url, notice: 'Ztl was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_ztl }
      else
        format.html { render :edit }
        format.json { render json: @admin_ztl.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/ztls/1
  # DELETE /admin/ztls/1.json
  def destroy
    @admin_ztl.destroy
    respond_to do |format|
      format.html { redirect_to admin_ztls_url, notice: 'Ztl was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_ztl
      @admin_ztl = Ztl.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_ztl_params
      params.require(:ztl).permit(:name, :description, coordinates_attributes: [:id, :latitude, :longitude, :_destroy])
    end
end
