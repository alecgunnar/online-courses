class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :force_sign_in
  before_action :require_api_auth

  protected
    def force_sign_in
      redirect_to(sign_in_path, alert: flash[:alert] || 'You must sign in first!') unless user_signed_in?
    end

    def require_api_auth
      redirect_to(account_api_auth_path, alert: flash[:alert] || 'You must authenticate with ELearning!') unless current_user.valid_api_token_data?
    end
end
