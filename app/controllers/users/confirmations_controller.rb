class Users::ConfirmationsController < Devise::ConfirmationsController
  skip_before_action :force_sign_in, only: [:new, :create, :show]

  layout 'guest'

  protected
    def after_resending_confirmation_instructions_path_for (resource)
      sign_in_path
    end

    def after_confirmation_path_for(resource_name, resource)
      sign_in_path
    end
end
