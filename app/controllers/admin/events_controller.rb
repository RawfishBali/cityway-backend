class Admin::EventsController < Admin::BaseController
  before_action :set_admin_event, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource param_method: :admin_event_params

  # GET /admin/events
  # GET /admin/events.json
  def index
    if params[:name]
      @admin_events = City.find(session[:current_city_id]).around.events.where('lower(title) like ?', "%#{params[:name].downcase}%").page(params[:page]).per(10)
    else
      @admin_events = City.find(session[:current_city_id]).around.events.page(params[:page]).per(10)
    end

  end

  # GET /admin/events/1
  # GET /admin/events/1.json
  def show
  end

  # GET /admin/events/new
  def new
    @admin_event = Event.new
    @around_id = City.find(session[:current_city_id]).around.id
  end

  # GET /admin/events/1/edit
  def edit
  end

  # POST /admin/events
  # POST /admin/events.json
  def create
    @admin_event = Event.new(admin_event_params)

    respond_to do |format|
      if @admin_event.save
        format.html { redirect_to session['previous_url'] || admin_events_url, notice: 'Eventi è stato creato con successo.' }
        format.json { render :show, status: :created, location: @admin_event }
      else
        @around_id = City.find(session[:current_city_id]).around.id
        format.html { render :new }
        format.json { render json: @admin_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/events/1
  # PATCH/PUT /admin/events/1.json
  def update
    respond_to do |format|
      if @admin_event.update(admin_event_params)
        format.html { redirect_to session['previous_url'] || admin_events_url, notice: 'Eventi è stato aggiornato con successo.' }
        format.json { render :show, status: :ok, location: @admin_event }
      else
        @around_id = City.find(session[:current_city_id]).around.id
        format.html { render :edit }
        format.json { render json: @admin_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/events/1
  # DELETE /admin/events/1.json
  def destroy
    @admin_event.destroy
    respond_to do |format|
      format.html { redirect_to session['previous_url'] || admin_events_url, notice: 'Eventi cancellata con successo!.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_event
      @admin_event = Event.find(params[:id])
      @around_id = City.find(session[:current_city_id]).around.id
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_event_params
      params.require(:event).permit(:title, :address, :description, :around_id, :facebook, :website, :twitter, :instagram, :support_disabilities, :email,city_ids:[], event_dates_attributes: [:id, :open_time, :close_time, :event_date, :_destroy], photos_attributes: [:id, :picture,:is_primary,:position,:_destroy])
    end
end
