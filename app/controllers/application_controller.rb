class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :force_sign_in

  protected
    def force_sign_in
      redirect_to(sign_in_path, alert: flash[:alert] || 'You must sign in first!') unless user_signed_in?
    end
end
