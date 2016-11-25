class Admin::SchoolsController < Admin::BaseController
  before_action :set_admin_school, only: [:show, :edit, :update, :destroy]

  # GET /admin/schools
  # GET /admin/schools.json
  def index
    @school_types = ((SCHOOL_DEFAULTS + City.find(session[:current_city_id]).utility.schools.map(&:school_type)).uniq.sort!)
    if params[:school_type] && params.has_key?(:public)
      @admin_schools = City.find(session[:current_city_id]).utility.schools.where("school_type = ? and is_public = ?", params[:school_type], params[:public]).page(params[:page]).per(10)
    else
      if params.has_key?(:public)
        @admin_schools = City.find(session[:current_city_id]).utility.schools.where(is_public: params[:public]).page(params[:page]).per(10)
      else
        @admin_schools = City.find(session[:current_city_id]).utility.schools.page(params[:page]).per(10)
      end

    end

  end

  # GET /admin/schools/1
  # GET /admin/schools/1.json
  def show
  end

  # GET /admin/schools/new
  def new
    @school_types = ((SCHOOL_DEFAULTS + City.find(session[:current_city_id]).utility.schools.map(&:school_type)).uniq.sort!).join(",").humanize.titleize
    @admin_school = City.find(session[:current_city_id]).utility.schools.new
    @is_public = params[:public]
  end

  # GET /admin/schools/1/edit
  def edit
  end

  # POST /admin/schools
  # POST /admin/schools.json
  def create
    params[:school][:school_type] = params[:school][:school_type].strip.downcase.gsub(" ","_")
    @admin_school = City.find(session[:current_city_id]).utility.schools.new(admin_school_params)

    respond_to do |format|
      if @admin_school.save
        format.html { redirect_to admin_schools_url(public: @admin_school.is_public), notice: 'Scuola è stato creato con successo.' }
        format.json { render :show, status: :created, location: @admin_school }
      else
        format.html { render :new }
        format.json { render json: @admin_school.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/schools/1
  # PATCH/PUT /admin/schools/1.json
  def update
    respond_to do |format|
      params[:school][:school_type] = params[:school][:school_type].strip.downcase.gsub(" ","_")
      @school_types = ((SCHOOL_DEFAULTS + City.find(session[:current_city_id]).utility.schools.map(&:school_type)).uniq.sort!).join(",").humanize.titleize
      if @admin_school.update(admin_school_params)
        format.html { redirect_to admin_schools_url(public: @admin_school.is_public), notice: 'Scuola è stato aggiornato con successo.' }
        format.json { render :show, status: :ok, location: @admin_school }
      else
        format.html { render :edit }
        format.json { render json: @admin_school.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/schools/1
  # DELETE /admin/schools/1.json
  def destroy
    @admin_school.destroy
    respond_to do |format|
      format.html { redirect_to admin_schools_url(public: @admin_school.is_public), notice: 'Scuola è stato distrutto con successo.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_school
      @admin_school = School.find(params[:id])
      @is_public = @admin_school.is_public
      @school_types = ((SCHOOL_DEFAULTS + City.find(session[:current_city_id]).utility.schools.map(&:school_type)).uniq.sort!).join(",").humanize.titleize
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_school_params
      params.require(:school).permit!

    end
end
