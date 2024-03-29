class Admin::CulinariesController < Admin::BaseController
  before_action :set_admin_culinary, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource param_method: :admin_culinary_params

  # GET /admin/culinaries
  # GET /admin/culinaries.json
  def index
    @admin_culinaries = City.find(session[:current_city_id]).discover.culinaries.where(culinary_type: Culinary.culinary_types[params[:culinary_type]]).page(params[:page]).per(10)
  end

  # GET /admin/culinaries/1
  # GET /admin/culinaries/1.json
  def show
  end

  # GET /admin/culinaries/new
  def new
    @discover_id = City.find(session[:current_city_id]).discover.id
    @admin_culinary = Culinary.new
    @culinary_type = params[:culinary_type]
  end

  # GET /admin/culinaries/1/edit
  def edit
  end

  # POST /admin/culinaries
  # POST /admin/culinaries.json
  def create
    @admin_culinary = City.find(session[:current_city_id]).discover.culinaries.new(admin_culinary_params)
    @culinary_type = params[:culinary][:culinary_type]
    respond_to do |format|
      if @admin_culinary.save
        italian_type = { gastronomy: 'Gastronomia', traditional: 'Piatti della Tradizione' }
        format.html { redirect_to session['previous_url'] || admin_culinaries_url(culinary_type: @admin_culinary.culinary_type), notice: "#{italian_type[@culinary_type.to_sym]} è stato creato con successo." }
        format.json { render :show, status: :created, location: @admin_culinary }
      else
        format.html { render :new }
        format.json { render json: @admin_culinary.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/culinaries/1
  # PATCH/PUT /admin/culinaries/1.json
  def update
    respond_to do |format|
      if @admin_culinary.update(admin_culinary_params)
        italian_type = { gastronomy: 'Gastronomia', traditional: 'Piatti della Tradizione' }
        format.html { redirect_to session['previous_url'] || admin_culinaries_url(culinary_type: @admin_culinary.culinary_type), notice:
          "#{italian_type[@culinary_type.to_sym]} è stato aggiornato con successo." }
        format.json { render :show, status: :ok, location: @admin_culinary }
      else
        format.html { render :edit }
        format.json { render json: @admin_culinary.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/culinaries/1
  # DELETE /admin/culinaries/1.json
  def destroy
    @admin_culinary.destroy
    respond_to do |format|
      italian_type = { gastronomy: 'Gastronomia', traditional: 'Piatti della Tradizione' }
      format.html { redirect_to session['previous_url'] || admin_culinaries_url, notice: "#{italian_type[@culinary_type.to_sym]} cancellata con successo!." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_culinary
      @admin_culinary = Culinary.find(params[:id])
      @discover_id = @admin_culinary.discover.id
      @culinary_type = @admin_culinary.culinary_type
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_culinary_params
      params.require(:culinary).permit(:name, :description, :culinary_type, :external_link, :support_disabilities, photos_attributes: [:id, :picture, :position, :is_primary, :_destroy])
    end
end
