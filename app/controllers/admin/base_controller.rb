class Admin::BaseController < ApplicationController
  # layout "admin"
  before_action :authenticate_admin!
  before_action :set_cities

  def set_cities
    @selected_city = session[:current_city_id].blank? ? City.first :  City.find(session[:current_city_id])
    @cities = City.all
  end

  

end
