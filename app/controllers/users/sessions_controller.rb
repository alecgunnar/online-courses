class Users::SessionsController < Devise::SessionsController
  skip_before_action :force_sign_in, only: [:new, :create, :destroy]

  layout 'guest'
end
