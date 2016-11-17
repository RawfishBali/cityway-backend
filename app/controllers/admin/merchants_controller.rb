class Admin::MerchantsController < Admin::BaseController
  before_action :set_admin_merchant, only: [:show, :edit, :update, :destroy]
  before_action :prepare_categories, only: [:new, :edit, :create, :update]

  # GET /admin/merchants
  # GET /admin/merchants.json
  def index
    if params[:category_id]
      @admin_merchants = City.find(session[:current_city_id]).categories.find(params[:category_id]).merchants.order('name ASC').page(params[:page]).per(10)
    else
      @admin_merchants = City.find(session[:current_city_id]).merchants.order('name ASC').page(params[:page]).per(10)
    end

    @categories =  City.find(session[:current_city_id]).parent_categories
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
        format.html { redirect_to session['previous_url'] || admin_merchants_path, notice: 'Merchant è stato creato con successo.' }
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
        format.html { redirect_to session['previous_url'] || admin_merchants_path, notice: 'Merchant è stato aggiornato con successo.' }
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
      format.html { redirect_to admin_merchants_url, notice: 'Merchant è stato distrutto con successo.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_merchant
      @admin_merchant = Merchant.find(params[:id])
      city = City.find(session[:current_city_id])

    end

    def prepare_categories
      city = City.find(session[:current_city_id])
      @categories = city.sorted_categories
      @categories.each do |category|
        category.subcategories do |subcategory|
          @subcategories << subcategory
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_merchant_params
      params.require(:merchant).permit!
      # params.require(:merchant).permit(:name, :address, :description, :photo, :icon, :email, :website, :instagram, :facebook, :city_id, :category_id, :subcategories, :phone, subcategory_ids: [], photos_attributes: [:id, :picture, :is_primary, :position,  :_destroy], business_hours_attributes: [:id, :morning_open_time, :morning_close_time, :evening_open_time,
        # :evening_close_time, :day, :_destroy])
    end
end
