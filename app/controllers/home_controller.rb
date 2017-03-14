class HomeController < Admin::BaseController
  def index
    if current_admin.has_role? :merchant_admin
      @cities = City.where('id in (?)', current_admin.merchants.map(&:city_id)).order('Name ASC')
    else
      @cities = City.all.order('Name ASC')
    end
  end
end
