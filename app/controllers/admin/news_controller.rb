class Admin::NewsController < Admin::BaseController
  before_action :set_admin_news, only: [:show, :edit, :update, :destroy]

  # GET /admin/news
  # GET /admin/news.json
  def index
    @admin_news = City.find(session[:current_city_id]).commonplace.news.page(params[:page]).per(10)
  end

  # GET /admin/news/1
  # GET /admin/news/1.json
  def show
  end

  # GET /admin/news/new
  def new
    @admin_news = Admin::News.new
    @commonplace_id = City.find(session[:current_city_id]).commonplace.id
  end

  # GET /admin/news/1/edit
  def edit
  end

  # POST /admin/news
  # POST /admin/news.json
  def create
    @admin_news = Admin::News.new(admin_news_params)

    respond_to do |format|
      if @admin_news.save
        format.html { redirect_to admin_news_index_url, notice: 'News was successfully created.' }
        format.json { render :show, status: :created, location: @admin_news }
      else
        format.html { render :new }
        format.json { render json: @admin_news.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/news/1
  # PATCH/PUT /admin/news/1.json
  def update
    respond_to do |format|
      if @admin_news.update(admin_news_params)
        format.html { redirect_to admin_news_index_url, notice: 'News was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_news }
      else
        format.html { render :edit }
        format.json { render json: @admin_news.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/news/1
  # DELETE /admin/news/1.json
  def destroy
    @admin_news.destroy
    respond_to do |format|
      format.html { redirect_to admin_news_index_url, notice: 'News was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_news
      @admin_news = Admin::News.find(params[:id])
      @commonplace_id = @admin_news.commonplace.id
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_news_params
      params.require(:news).permit(:title, :description, :commonplace_id, :published_at, photos_attributes: [:id, :picture, :position, :is_primary, :_destroy])
    end
end
