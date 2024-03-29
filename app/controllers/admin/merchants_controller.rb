class Admin::MerchantsController < Admin::BaseController
  before_action :set_admin_merchant, only: [:show, :edit, :update, :destroy]
  before_action :prepare_categories, only: [:new, :edit, :create, :update]
  load_and_authorize_resource param_method: :admin_merchant_params
  skip_before_action :verify_authenticity_token, only: [:remove_icon]

  # GET /admin/merchants
  # GET /admin/merchants.json
  def index
    if params[:category_id]
      if params[:name]
        @admin_merchants = City.find(session[:current_city_id]).categories.find(params[:category_id]).merchants.where('lower(name) like ?', "%#{params[:name].downcase}%").order('name ASC')
      else
        @admin_merchants = City.find(session[:current_city_id]).categories.find(params[:category_id]).merchants.order('name ASC')
      end
    else
      if params[:name]
        @admin_merchants = City.find(session[:current_city_id]).merchants.where('lower(name) like ?', "%#{params[:name].downcase}%").order('name ASC')
      else
        @admin_merchants = City.find(session[:current_city_id]).merchants.order('name ASC')
      end
    end

    @admin_merchants =  @admin_merchants.where(admin_id: current_admin.id) if current_admin.has_role? :merchant_admin
    @admin_merchants = @admin_merchants.page(params[:page]).per(10)
    @categories =  City.find(session[:current_city_id]).parent_categories.uniq
  end

  # GET /admin/merchants/1
  # GET /admin/merchants/1.json
  def show
  end

  # GET /admin/merchants/new
  def new
    @admin_merchant = Merchant.new
  end

  # GET /admin/merchants/1/edit
  def edit
  end

  # POST /admin/merchants
  # POST /admin/merchants.json
  def create
    @admin_merchant = Merchant.new(admin_merchant_params)

    respond_to do |format|
      if @admin_merchant.save
        format.html { redirect_to session['previous_url'] || admin_merchants_path, notice: 'Attività è stato creato con successo.' }
        format.json { render :show, status: :created, location: @admin_merchant }
      else
        format.html { render :new }
        format.json { render json: @admin_merchant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/merchants/1
  # PATCH/PUT /admin/merchants/1.json
  def update
    respond_to do |format|
      if @admin_merchant.update(admin_merchant_params)
        format.html { redirect_to session['previous_url'] || admin_merchants_path, notice: 'Attività è stato aggiornato con successo.' }
        format.json { render :show, status: :ok, location: admin_merchants_path }
      else
        format.html { render :edit }
        format.json { render json: @admin_merchant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/merchants/1
  # DELETE /admin/merchants/1.json
  def destroy
    @admin_merchant.destroy
    respond_to do |format|
      format.html { redirect_to admin_merchants_url, notice: 'Attività cancellata con successo!.' }
      format.json { head :no_content }
    end
  end

  def remove_icon

    @admin_merchant = Merchant.find(params[:id])
    @admin_merchant.remove_icon!
    @admin_merchant.save
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_merchant
      @admin_merchant = Merchant.find(params[:id])
      city = City.find(session[:current_city_id])
      @admin_merchant.update(active: false) unless @admin_merchant.is_active
    end

    def prepare_categories
      city = City.find(session[:current_city_id])
      @categories = city.sorted_categories
      @subcategories = []
      @categories.each do |category|
        category.subcategories.each do |subcategory|
          @subcategories << subcategory
        end
      end
      @subcategories.sort_by(&:name)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_merchant_params
      params.require(:merchant).permit!
    end
end
