class Admin::CategoriesController < Admin::BaseController
  before_action :set_admin_category, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource param_method: :admin_category_params

  # GET /admin/categories
  # GET /admin/categories.json
  def index
    city = City.find(session[:current_city_id])
    @admin_categories = city.sorted_categories
  end

  # GET /admin/categories/1
  # GET /admin/categories/1.json
  def show
  end

  # GET /admin/categories/new
  def new
    @admin_category = City.find(session[:current_city_id]).categories.new
  end

  # GET /admin/categories/1/edit
  def edit
  end

  # POST /admin/categories
  # POST /admin/categories.json
  def create
    @admin_category = City.find(session[:current_city_id]).categories.new(admin_category_params)

    respond_to do |format|
      if @admin_category.save
        @admin_category.cities << City.find(session[:current_city_id])
        format.html { redirect_to session['previous_url'] || admin_categories_url, notice: 'Categorie è stato creato con successo.' }
        format.json { render :show, status: :created, location: @admin_category }
      else
        format.html { render :new }
        format.json { render json: @admin_category.errors, status: :unprocessable_entity }
      end
    end
  end

  def order
    category_ids = []
    params[:category_ids].each do |category|
      category_ids << category[1]['id'].to_i
    end

    City.find(session[:current_city_id]).categories.order_by_ids(category_ids).each_with_index do |c,i|
      c.categories_cities.first.update(priority: i)
    end
    render json: 'ok'
  end

  # PATCH/PUT /admin/categories/1
  # PATCH/PUT /admin/categories/1.json
  def update
    respond_to do |format|
      if @admin_category.update(admin_category_params)
        format.html { redirect_to session['previous_url'] || admin_categories_url, notice: 'Categorie è stato aggiornato con successo.' }
        format.json { render :show, status: :ok, location: @admin_category }
      else
        format.html { render :edit }
        format.json { render json: @admin_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/categories/1
  # DELETE /admin/categories/1.json
  def destroy
    @admin_category.destroy
    respond_to do |format|
      format.html { redirect_to admin_categories_url, notice: 'Categorie cancellata con successo!.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_category
      @admin_category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_category_params
      params.require(:category).permit(:photo, :icon, :name, :city_ids, subcategories_attributes: [:id, :name, :_destroy])
    end
end
