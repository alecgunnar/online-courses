class Users::SessionsController < Devise::SessionsController
  skip_before_action :force_sign_in, only: [:new, :create, :destroy]

  layout 'guest'

  protected
    def after_sign_out_path_for (resource_or_scope)
      sign_in_path
    end
end
