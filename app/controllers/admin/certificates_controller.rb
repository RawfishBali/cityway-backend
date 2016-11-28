class Admin::CertificatesController < Admin::BaseController
  before_action :set_admin_certificate, only: [:show, :edit, :update, :destroy]

  # GET /admin/certificates
  # GET /admin/certificates.json
  def index
    @admin_certificates = City.find(session[:current_city_id]).commonplace.certificates.page(params[:page]).per(10)
  end

  # GET /admin/certificates/1
  # GET /admin/certificates/1.json
  def show
  end

  # GET /admin/certificates/new
  def new
    @admin_certificate = City.find(session[:current_city_id]).commonplace.certificates.new
  end

  # GET /admin/certificates/1/edit
  def edit
  end

  # POST /admin/certificates
  # POST /admin/certificates.json
  def create
    @admin_certificate = City.find(session[:current_city_id]).commonplace.certificates.new(admin_certificate_params)

    respond_to do |format|
      if @admin_certificate.save
        format.html { redirect_to session['previous_url'] || admin_certificates_url, notice: 'Certificate è stato creato con successo.' }
        format.json { render :show, status: :created, location: @admin_certificate }
      else
        format.html { render :new }
        format.json { render json: @admin_certificate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/certificates/1
  # PATCH/PUT /admin/certificates/1.json
  def update
    respond_to do |format|
      if @admin_certificate.update(admin_certificate_params)
        format.html { redirect_to session['previous_url'] || admin_certificates_url, notice: 'Certificate è stato aggiornato con successo.' }
        format.json { render :show, status: :ok, location: @admin_certificate }
      else
        format.html { render :edit }
        format.json { render json: @admin_certificate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/certificates/1
  # DELETE /admin/certificates/1.json
  def destroy
    @admin_certificate.destroy
    respond_to do |format|
      format.html { redirect_to admin_certificates_url, notice: 'Certificate cancellata con successo!.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_certificate
      @admin_certificate = Certificate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_certificate_params
      params.require(:certificate).permit(:name, :url, :commonplace_id)
    end
end
