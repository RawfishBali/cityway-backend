class Admin::StoriesController < Admin::BaseController
  before_action :set_admin_story, only: [:show, :edit, :update, :destroy]

  # GET /admin/stories
  # GET /admin/stories.json
  def index
    @admin_stories = City.find(session[:current_city_id]).discover.story
  end

  # GET /admin/stories/1
  # GET /admin/stories/1.json
  def show
  end

  # GET /admin/stories/new
  def new
    @discover_id = City.find(session[:current_city_id]).discover.id
    @admin_story = Story.new
  end

  # GET /admin/stories/1/edit
  def edit
  end

  # POST /admin/stories
  # POST /admin/stories.json
  def create
    @admin_story = Story.new(admin_story_params)

    respond_to do |format|
      if @admin_story.save
        format.html { redirect_to session['previous_url'] || admin_stories_url, notice: 'Storia dela citta è stato creato con successo.' }
        format.json { render :show, status: :created, location: @admin_story }
      else
        format.html { render :new }
        format.json { render json: @admin_story.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/stories/1
  # PATCH/PUT /admin/stories/1.json
  def update
    respond_to do |format|
      if @admin_story.update(admin_story_params)
        format.html { redirect_to session['previous_url'] || admin_stories_url, notice: 'Storia dela citta è stato aggiornato con successo.' }
        format.json { render :show, status: :ok, location: @admin_story }
      else
        format.html { render :edit }
        format.json { render json: @admin_story.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/stories/1
  # DELETE /admin/stories/1.json
  def destroy
    @admin_story.destroy
    respond_to do |format|
      format.html { redirect_to session['previous_url'] || admin_stories_url, notice: 'Storia dela citta cancellata con successo!.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_story
      @admin_story = Story.find(params[:id])
      @discover_id = City.find(session[:current_city_id]).discover.id
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_story_params
      params.require(:story).permit(:top_text, :bottom_text, :discover_id,:external_link, photos_attributes: [:id, :picture,:is_primary,:position,:_destroy])
    end
end
