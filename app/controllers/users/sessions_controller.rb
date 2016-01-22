class Users::SessionsController < Devise::SessionsController
  skip_before_action :force_sign_in, only: [:new, :create, :destroy]

  layout 'guest'

  protected
    def after_sign_in_path_for (resource)
      if not current_user.valid_api_token_data
        account_api_auth_path
      else
        root_path
      end
    end

    def after_sign_out_path_for (resource)
      sign_in_path
    end
end
