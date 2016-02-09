require 'ims/lti'
require 'oauth/request_proxy/rack_request'

OAUTH_10_SUPPORT = true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :has_launched

  private
    def has_launched
      if session['launch_params'].nil?
        redirect_to lti_error_path, alert: 'This application has not been launched properly.'
      else
        @launch_params = LaunchParams.new session['launch_params']
      end
    end
end
