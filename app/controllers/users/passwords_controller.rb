class Users::PasswordsController < Devise::PasswordsController
  skip_before_action :force_sign_in, only: [:new, :create, :edit, :update]
  skip_before_action :require_api_auth

  layout 'guest'

  protected
    def after_sending_reset_password_instructions_path_for (resource)
      sign_in_path
    end

    def after_resetting_password_path_for (resource)
      sign_in_path
    end
end
