class HomeController < Admin::BaseController
  def index
    @cities = City.all.order('name ASC')
  end
end
