class Admin::CoursesController < Admin::BaseController
  before_action :set_admin_course, only: [:show, :edit, :update, :destroy]
  before_action :set_course_types, only: [:new, :edit, :show, :index]
  load_and_authorize_resource

  # GET /admin/courses
  # GET /admin/courses.json
  def index
    if params[:course_type]
      @admin_courses = City.find(session[:current_city_id]).utility.courses.where("course_type = ?", params[:course_type]).order('created_at DESC').page(params[:page]).per(10)
    else
      @admin_courses = City.find(session[:current_city_id]).utility.courses.order('created_at DESC').page(params[:page]).per(10)
    end

  end

  # GET /admin/courses/1
  # GET /admin/courses/1.json
  def show
  end

  # GET /admin/courses/new
  def new
    @admin_course = Course.new
  end

  # GET /admin/courses/1/edit
  def edit
  end

  # POST /admin/courses
  # POST /admin/courses.json
  def create
    @admin_course =  City.find(session[:current_city_id]).utility.courses.new(admin_course_params)

    respond_to do |format|
      if @admin_course.save
        format.html { redirect_to admin_courses_url, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @admin_course }
      else
        format.html { render :new }
        format.json { render json: @admin_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/courses/1
  # PATCH/PUT /admin/courses/1.json
  def update
    respond_to do |format|
      if @admin_course.update(admin_course_params)
        format.html { redirect_to admin_courses_url, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_course }
      else
        format.html { render :edit }
        format.json { render json: @admin_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/courses/1
  # DELETE /admin/courses/1.json
  def destroy
    @admin_course.destroy
    respond_to do |format|
      format.html { redirect_to admin_courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_course_types
      @course_types = ((City.find(session[:current_city_id]).utility.courses.map(&:course_type)).uniq.sort!)
    end

    def set_admin_course
      @admin_course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_course_params
      params.require(:course).permit!
    end
end
