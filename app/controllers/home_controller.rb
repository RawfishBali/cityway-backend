class HomeController < Admin::BaseController
  def index
    @cities = City.all
  end
end
