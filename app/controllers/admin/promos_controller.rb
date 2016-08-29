class Admin::PromosController < ApplicationController
  before_action :set_admin_promo, only: [:show, :edit, :update, :destroy]

  # GET /admin/promos
  # GET /admin/promos.json
  def index
    @admin_promos = Admin::Promo.all
  end

  # GET /admin/promos/1
  # GET /admin/promos/1.json
  def show
  end

  # GET /admin/promos/new
  def new
    @admin_promo = Admin::Promo.new
  end

  # GET /admin/promos/1/edit
  def edit
  end

  # POST /admin/promos
  # POST /admin/promos.json
  def create
    @admin_promo = Admin::Promo.new(admin_promo_params)

    respond_to do |format|
      if @admin_promo.save
        format.html { redirect_to @admin_promo, notice: 'Promo was successfully created.' }
        format.json { render :show, status: :created, location: @admin_promo }
      else
        format.html { render :new }
        format.json { render json: @admin_promo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/promos/1
  # PATCH/PUT /admin/promos/1.json
  def update
    respond_to do |format|
      if @admin_promo.update(admin_promo_params)
        format.html { redirect_to @admin_promo, notice: 'Promo was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_promo }
      else
        format.html { render :edit }
        format.json { render json: @admin_promo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/promos/1
  # DELETE /admin/promos/1.json
  def destroy
    @admin_promo.destroy
    respond_to do |format|
      format.html { redirect_to admin_promos_url, notice: 'Promo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_promo
      @admin_promo = Admin::Promo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_promo_params
      params.fetch(:admin_promo, {})
    end
end
