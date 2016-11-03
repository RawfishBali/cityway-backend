class Admin::AdvertisementsController < Admin::BaseController
  before_action :set_advertisement, only: [:show, :edit, :update, :destroy]

  # GET /admin/advertisements
  # GET /admin/advertisements.json
  def index
    @advertisements = Advertisement.all.page params[:page]
    @advertisement = Advertisement.new
  end

  # GET /admin/advertisements/1
  # GET /admin/advertisements/1.json
  def show
  end

  # GET /admin/advertisements/new
  def new
    @advertisement = Advertisement.new
  end

  # GET /admin/advertisements/1/edit
  def edit
  end

  # POST /admin/advertisements
  # POST /admin/advertisements.json
  def create
    @advertisement = Advertisement.new(admin_advertisement_params)

    respond_to do |format|
      if @advertisement.save
        format.html { redirect_to (session['previous_url'] || admin_advertisements_path), notice: 'Advertisement è stato creato con successo.' }
        format.json { render :show, status: :created, location: @advertisement }
      else
        format.html { redirect_to admin_advertisements_path, notice: 'Advertisement è stato creato con successo.' }
        format.json { render json: @advertisement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/advertisements/1
  # PATCH/PUT /admin/advertisements/1.json
  def update
    respond_to do |format|
      if @advertisement.update(admin_advertisement_params)

        format.html { redirect_to (session['previous_url'] || admin_advertisements_path), notice: 'Advertisement è stato aggiornato con successo.' }
        format.json { render :show, status: :ok, location: @advertisement }
      else
        format.html { redirect_to edit_admin_advertisement_path(@advertisement), notice: 'Advertisement è stato creato con successo.'}
        format.json { render json: @advertisement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/advertisements/1
  # DELETE /admin/advertisements/1.json
  def destroy
    @advertisement.destroy
    respond_to do |format|
      format.html { redirect_to admin_advertisements_url, notice: 'Advertisement è stato distrutto con successo.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_advertisement
      @advertisement = Advertisement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_advertisement_params
      params.require(:advertisement).permit(:photo ,:start_date, :end_date, :second_start_date, :second_end_date, :position, city_ids:[])
    end
end
