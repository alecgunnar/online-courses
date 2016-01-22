include D2lApi

class Users::SessionsController < Devise::SessionsController
  skip_before_action :force_sign_in, only: [:new, :create, :destroy]
  skip_before_action :require_api_auth

  layout 'guest'

  protected
    def after_sign_in_path_for (resource)
      if (not current_user.valid_api_token_data?) or (not get_user current_user)
        account_api_auth_path
      else
        root_path
      end
    end

    def after_sign_out_path_for (resource)
      sign_in_path
    end
end
