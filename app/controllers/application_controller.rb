require 'ims/lti'
require 'oauth/request_proxy/rack_request'

OAUTH_10_SUPPORT = true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :has_launched

  protected
    def update_launch_session_data (params)
      session[:launch_params] = params
      @launch_params          = LaunchParams.new params
    end

    def redirect_user
      if @launch_params.instructor?
        redirect_to manage_path
      else
        redirect_to submit_path
      end
    end

  private
    def has_launched
      if session[:launch_params].nil?
        redirect_to launch_error_path, alert: t('errors.launch.invalid_launch')
      else
        update_launch_session_data session[:launch_params]
      end
    end
end
