class HomeController < Admin::BaseController
  def index
  end

  def attivita
    check_role [:super_admin, :city_admin]
  end
end
