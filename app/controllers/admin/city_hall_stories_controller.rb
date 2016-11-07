class Admin::CityHallStoriesController < Admin::BaseController
  before_action :set_admin_city_hall_story, only: [:show, :edit, :update, :destroy]

  # GET /admin/city_hall_stories
  # GET /admin/city_hall_stories.json
  def index
    @admin_city_hall_stories = City.find(session[:current_city_id]).commonplace.city_hall_story
  end

  # GET /admin/city_hall_stories/1
  # GET /admin/city_hall_stories/1.json
  def show
  end

  # GET /admin/city_hall_stories/new
  def new
    @commonplace_id = City.find(session[:current_city_id]).commonplace.id
    @admin_city_hall_story = CityHallStory.new
    1.times{ @admin_city_hall_story.photos.build }
  end

  # GET /admin/city_hall_stories/1/edit
  def edit
  end

  # POST /admin/city_hall_stories
  # POST /admin/city_hall_stories.json
  def create
    @admin_city_hall_story = CityHallStory.new(admin_city_hall_story_params)

    respond_to do |format|
      if @admin_city_hall_story.save
        format.html { redirect_to session['previous_url'] || admin_city_hall_stories_url, notice: 'City hall story è stato creato con successo.' }
        format.json { render :show, status: :created, location: @admin_city_hall_story }
      else
        format.html { render :new }
        format.json { render json: @admin_city_hall_story.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/city_hall_stories/1
  # PATCH/PUT /admin/city_hall_stories/1.json
  def update
    respond_to do |format|
      if @admin_city_hall_story.update(admin_city_hall_story_params)
        format.html { redirect_to session['previous_url'] || admin_city_hall_stories_url, notice: 'City hall story è stato aggiornato con successo.' }
        format.json { render :show, status: :ok, location: @admin_city_hall_story }
      else
        format.html { render :edit }
        format.json { render json: @admin_city_hall_story.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/city_hall_stories/1
  # DELETE /admin/city_hall_stories/1.json
  def destroy
    @admin_city_hall_story.destroy
    respond_to do |format|
      format.html { redirect_to admin_city_hall_stories_url, notice: 'City hall story è stato distrutto con successo.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_city_hall_story
      @admin_city_hall_story = Admin::CityHallStory.find(params[:id])
      @commonplace_id = @admin_city_hall_story.commonplace.id
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_city_hall_story_params
      params.require(:city_hall_story).permit(:top_text, :bottom_text, :commonplace_id, photos_attributes: [:id, :picture,:is_primary,:position,:_destroy])
    end
end
