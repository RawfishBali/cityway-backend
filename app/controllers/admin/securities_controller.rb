class Admin::SecuritiesController < Admin::BaseController
  before_action :set_admin_security, only: [:show, :edit, :update, :destroy]

  # GET /admin/securities
  # GET /admin/securities.json
  def index
    @admin_securities = City.find(session[:current_city_id]).commonplace.securities.page(params[:page]).per(10)

  end

  # GET /admin/securities/1
  # GET /admin/securities/1.json
  def show
  end

  # GET /admin/securities/new
  def new
    @commonplace_id = City.find(session[:current_city_id]).commonplace.id
    @admin_security = Security.new
  end

  # GET /admin/securities/1/edit
  def edit
  end

  # POST /admin/securities
  # POST /admin/securities.json
  def create
    @commonplace_id = City.find(session[:current_city_id]).commonplace.id
    @admin_security = Security.new(admin_security_params)

    respond_to do |format|
      if @admin_security.save
        format.html { redirect_to session['previous_url'] ||  admin_securities_url, notice: 'Sicurezza è stato creato con successo.' }
        format.json { render :show, status: :created, location: @admin_security }
      else
        format.html { render :new }
        format.json { render json: @admin_security.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/securities/1
  # PATCH/PUT /admin/securities/1.json
  def update
    respond_to do |format|
      if @admin_security.update(admin_security_params)
        format.html { redirect_to session['previous_url'] || admin_securities_url, notice: 'Sicurezza è stato aggiornato con successo.' }
        format.json { render :show, status: :ok, location: @admin_security }
      else
        format.html { render :edit }
        format.json { render json: @admin_security.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/securities/1
  # DELETE /admin/securities/1.json
  def destroy
    @admin_security.destroy
    respond_to do |format|
      format.html { redirect_to admin_securities_url, notice: 'Sicurezza cancellata con successo!.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_security
      @admin_security = Admin::Security.find(params[:id])
      @commonplace_id = @admin_security.commonplace.id
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_security_params
      params.require(:security).permit(:name, :url, :commonplace_id)
    end
end
