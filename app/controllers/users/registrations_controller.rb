class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :force_sign_in, only: [:new, :create]
  skip_before_action :require_api_auth

  layout 'guest'
end
