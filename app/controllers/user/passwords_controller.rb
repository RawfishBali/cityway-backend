class User::PasswordsController < Devise::PasswordsController
  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      if Devise.sign_in_after_reset_password
        flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
        set_flash_message!(:notice, flash_message)
        sign_in(resource_name, resource)
      else
        set_flash_message!(:notice, :updated_not_active)
      end
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