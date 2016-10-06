class Admin::MarketsController < Admin::BaseController
  before_action :set_admin_market, only: [:show, :edit, :update, :destroy]

  # GET /admin/markets
  # GET /admin/markets.json
  def index
    @admin_markets = City.find(session[:current_city_id]).around.markets
  end

  # GET /admin/markets/1
  # GET /admin/markets/1.json
  def show
  end

  # GET /admin/markets/new
  def new
    @admin_market = Market.new
    @around_id = City.find(session[:current_city_id]).around.id
  end

  # GET /admin/markets/1/edit
  def edit
  end

  # POST /admin/markets
  # POST /admin/markets.json
  def create
    @admin_market = Admin::Market.new(admin_market_params)

    respond_to do |format|
      if @admin_market.save
        format.html { redirect_to admin_markets_url, notice: 'Market was successfully created.' }
        format.json { render :show, status: :created, location: @admin_market }
      else
        format.html { render :new }
        format.json { render json: @admin_market.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/markets/1
  # PATCH/PUT /admin/markets/1.json
  def update
    respond_to do |format|
      if @admin_market.update(admin_market_params)
        format.html { redirect_to admin_markets_url, notice: 'Market was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_market }
      else
        format.html { render :edit }
        format.json { render json: @admin_market.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/markets/1
  # DELETE /admin/markets/1.json
  def destroy
    @admin_market.destroy
    respond_to do |format|
      format.html { redirect_to admin_markets_url, notice: 'Market was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_market
      @admin_market = Admin::Market.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_market_params
      params.fetch(:admin_market, {})
    end
end
