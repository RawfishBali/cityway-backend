class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :layout_by_resource

  protected

  def layout_by_resource
    puts params[:controller]
    return 'application' if params[:controller] == 'devise/passwords' || params[:controller] == 'user/passwords'
    if admin_signed_in?
      "admin"
    else
      "devise"
    end
  end
end
