class Admin::BaseController < ApplicationController
  layout "admin"
  before_action :authenticate_admin!

  def check_role roles
    roles.each do |role|
      unless current_admin.has_role? role.to_sym
        flash[:error] = "You don't have permission to access this action."
        return redirect_to root_path
      end

    end

  end
end
