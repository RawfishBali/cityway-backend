class Admin::SportsController < Admin::BaseController
  before_action :set_admin_sport, only: [:show, :edit, :update, :destroy]

  # GET /admin/sports
  # GET /admin/sports.json
  def index
    @sport_types = ((SPORT_DEFAULTS + City.find(session[:current_city_id]).utility.sports.map(&:sport_type)).uniq.sort!)
    if params[:sport_type]
      @admin_sports = City.find(session[:current_city_id]).utility.sports.where(sport_type: params[:sport_type]).order('created_at DESC').page(params[:page]).per(10)
    else
      @admin_sports = City.find(session[:current_city_id]).utility.sports.order('created_at DESC').page(params[:page]).per(10)
    end

  end

  # GET /admin/sports/1
  # GET /admin/sports/1.json
  def show
  end

  # GET /admin/sports/new
  def new
    @sport_types = ((SPORT_DEFAULTS + City.find(session[:current_city_id]).utility.sports.map(&:sport_type)).uniq.sort!).join(",").humanize.titleize
    @admin_sport = City.find(session[:current_city_id]).utility.sports.new
  end

  # GET /admin/sports/1/edit
  def edit
    @sport_types = ((SPORT_DEFAULTS + City.find(session[:current_city_id]).utility.sports.map(&:sport_type)).uniq.sort!).join(",").humanize.titleize
  end

  # POST /admin/sports
  # POST /admin/sports.json
  def create
    params[:sport][:sport_type] = params[:sport][:sport_type].strip.downcase.gsub(" ","_")
    @admin_sport = City.find(session[:current_city_id]).utility.sports.new(admin_sport_params)

    respond_to do |format|
      if @admin_sport.save
        format.html { redirect_to admin_sports_url, notice: 'Sport è stato creato con successo.' }
        format.json { render :show, status: :created, location: @admin_sport }
      else
        format.html { render :new }
        format.json { render json: @admin_sport.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/sports/1
  # PATCH/PUT /admin/sports/1.json
  def update
    params[:sport][:sport_type] = params[:sport][:sport_type].strip.downcase.gsub(" ","_")
    respond_to do |format|
      if @admin_sport.update(admin_sport_params)
        format.html { redirect_to admin_sports_url, notice: 'Sport è stato aggiornato con successo.' }
        format.json { render :show, status: :ok, location: @admin_sport }
      else
        format.html { render :edit }
        format.json { render json: @admin_sport.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/sports/1
  # DELETE /admin/sports/1.json
  def destroy
    @admin_sport.destroy
    respond_to do |format|
      format.html { redirect_to admin_sports_url, notice: 'Sport was successfully destroyed.cancellata con successo!.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_sport
      @admin_sport = Sport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_sport_params
      params.require(:sport).permit!
    end
end
