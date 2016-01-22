class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :force_sign_in

  protected
    def force_sign_in
      redirect_to(sign_in_path, alert: flash[:alert] || 'You must sign in first!') unless user_signed_in?
    end
end
