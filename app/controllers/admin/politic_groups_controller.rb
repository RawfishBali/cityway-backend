class Admin::PoliticGroupsController < Admin::BaseController
  before_action :set_admin_politic_group, only: [:show, :edit, :update, :destroy]

  # GET /admin/politic_groups
  # GET /admin/politic_groups.json
  def index

    @admin_politic_groups = City.find(session[:current_city_id]).commonplace.politic_groups.page(params[:page])
  end

  # GET /admin/politic_groups/1
  # GET /admin/politic_groups/1.json
  def show
  end

  # GET /admin/politic_groups/new
  def new
    @admin_politic_group = Admin::PoliticGroup.new
  end

  # GET /admin/politic_groups/1/edit
  def edit
  end

  # POST /admin/politic_groups
  # POST /admin/politic_groups.json
  def create
    @admin_politic_group = Admin::PoliticGroup.new(admin_politic_group_params)

    respond_to do |format|
      if @admin_politic_group.save
        format.html { redirect_to @admin_politic_group, notice: 'Politic group was successfully created.' }
        format.json { render :show, status: :created, location: @admin_politic_group }
      else
        format.html { render :new }
        format.json { render json: @admin_politic_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/politic_groups/1
  # PATCH/PUT /admin/politic_groups/1.json
  def update
    respond_to do |format|
      if @admin_politic_group.update(admin_politic_group_params)
        format.html { redirect_to @admin_politic_group, notice: 'Politic group was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_politic_group }
      else
        format.html { render :edit }
        format.json { render json: @admin_politic_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/politic_groups/1
  # DELETE /admin/politic_groups/1.json
  def destroy
    @admin_politic_group.destroy
    respond_to do |format|
      format.html { redirect_to admin_politic_groups_url, notice: 'Politic group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_politic_group
      @admin_politic_group = Admin::PoliticGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_politic_group_params
      params.fetch(:admin_politic_group, {})
    end
end
