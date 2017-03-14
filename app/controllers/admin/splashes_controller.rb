class Admin::SplashesController < Admin::BaseController
  before_action :set_admin_splash, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource param_method: :admin_splash_params

  # GET /admin/splashes
  # GET /admin/splashes.json
  def index
    @admin_splashes = Wizard.all
  end

  # GET /admin/splashes/1
  # GET /admin/splashes/1.json
  def show
  end

  # GET /admin/splashes/new
  def new
    @admin_splash = Wizard.new
  end

  # GET /admin/splashes/1/edit
  def edit
  end

  # POST /admin/splashes
  # POST /admin/splashes.json
  def create
    @admin_splash = Wizard.new(admin_splash_params)

    respond_to do |format|
      if @admin_splash.save
        format.html { redirect_to session['previous_url'] || admin_splashes_url, notice: 'Splash è stato creato con successo.' }
        format.json { render :show, status: :created, location: @admin_splash }
      else
        format.html { render :new }
        format.json { render json: @admin_splash.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/splashes/1
  # PATCH/PUT /admin/splashes/1.json
  def update
    respond_to do |format|
      if @admin_splash.update(admin_splash_params)
        format.html { redirect_to session['previous_url'] || admin_splashes_url, notice: 'Splash è stato aggiornato con successo.' }
        format.json { render :show, status: :ok, location: @admin_splash }
      else
        format.html { render :edit }
        format.json { render json: @admin_splash.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/splashes/1
  # DELETE /admin/splashes/1.json
  def destroy
    @admin_splash.destroy
    respond_to do |format|
      format.html { redirect_to session['previous_url'] || admin_splashes_url, notice: 'Splash cancellata con successo!.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_splash
      @admin_splash = Wizard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_splash_params
      params.require(:wizard).permit(:name, photos_attributes: [:id, :picture,:is_primary,:position,:_destroy])
    end
end
