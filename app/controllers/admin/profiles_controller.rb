class Admin::ProfilesController < Admin::BaseController
  before_action :set_admin_profile, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource param_method: :admin_profile_params

  # GET /admin/profiles
  # GET /admin/profiles.json
  def index
    if params[:major]
      @admin_profiles = City.find(session[:current_city_id]).commonplace.major
    else
      @admin_profiles = City.find(session[:current_city_id]).commonplace.city_councils_with_vice_major.page(params[:page])
    end

  end

  # GET /admin/profiles/1
  # GET /admin/profiles/1.json
  def show
  end

  # GET /admin/profiles/new
  def new
    @admin_profile = Profile.new
    @commonplace_id = City.find(session[:current_city_id]).commonplace.id
    @is_major = params[:major]
  end

  # GET /admin/profiles/1/edit
  def edit
  end

  # POST /admin/profiles
  # POST /admin/profiles.json
  def create
    @admin_profile = Profile.new(admin_profile_params)
    @commonplace_id = City.find(session[:current_city_id]).commonplace.id
    @is_major = @admin_profile.is_major
    redirect_path = session['previous_url'] || (@admin_profile.is_major ? admin_profiles_url(major:true) : admin_profiles_url)
    name_alias = @is_major ? 'Sindaco' : 'Giunta Comunale'
    respond_to do |format|
      if @admin_profile.save
        format.html { redirect_to redirect_path, notice: "#{name_alias} è stato creato con successo." }
        format.json { render :show, status: :created, location: @admin_profile }
      else
        format.html { render :new }
        format.json { render json: @admin_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/profiles/1
  # PATCH/PUT /admin/profiles/1.json
  def update
    redirect_path =  @admin_profile.is_major ? admin_profiles_url(major:true) : admin_profiles_url
    if @admin_profile.update(admin_profile_params)
      redirect_to session['previous_url'] || redirect_path, notice: "#{@name_alias} è stato aggiornato con successo."
    else
      if @admin_profile.politic_group_id
        params[:politic_group_id] = @admin_profile.politic_group_id
        render :edit
      else
        render :edit
      end
    end
  end

  # DELETE /admin/profiles/1
  # DELETE /admin/profiles/1.json
  def destroy
    @admin_profile.destroy
    redirect_to request.referrer, notice: "#{@name_alias} cancellata con successo!."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_profile
      @admin_profile = Profile.find(params[:id])
      @commonplace_id = City.find(session[:current_city_id]).commonplace.id
      @is_major = @admin_profile.is_major
      @name_alias = @is_major ? 'Sindaco' : 'Giunta Comunale'
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_profile_params
      params.require(:profile).permit(:commonplace_id, :is_city_council_member, :name, :role, :address, :email, :fax, :phone, :phone_1, :phone_2, :website, :appointment_start, :appointment_end, :description, :politic_group_id, :photo, :is_major, :is_vice_major, :unavailable, :major_icon, days_open: [])
    end
end
