class User::PasswordsController < Devise::PasswordsController
  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      set_flash_message!(:notice, :updated_not_active)

      if browser.platform.ios? || browser.platform.android?
        url_password = 'cityway://login'
      else
        url_password = after_resetting_password_path_for(resource)
      end
      respond_with resource, location: url_password
    else
      set_minimum_password_length
      respond_with resource
    end
  end
end
