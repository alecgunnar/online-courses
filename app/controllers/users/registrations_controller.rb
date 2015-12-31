class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :force_sign_in, only: [:new, :create]

  layout 'guest'
end
