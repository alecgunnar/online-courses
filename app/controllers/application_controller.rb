require 'ims/lti'
require 'oauth/request_proxy/rack_request'

OAUTH_10_SUPPORT = true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :has_launched

  protected
    def update_launch_session_data (params)
      session[:launch_params] = params
      launch_params           = LaunchParams.new params

      @session = Session.new launch_params
    end

    def not_found
      raise ActionController::RoutingError.new('Not Found')
    end

    def no_permission
      raise ActionController::RoutingError.new('Unauthorized')
    end

    def force_student
      if @session.instructor?
        @message = t('errors.launch.not_permitted')
        render 'general/error'
      end
    end

    def force_instructor
      if not @session.instructor?
        @message = t('errors.launch.not_permitted')
        render 'general/error'
      end
    end

  private
    def has_launched
      update_launch_session_data session[:launch_params]

      if @session.user.nil?
        redirect_to launch_error_path, alert: t('errors.launch.invalid_launch')
      else
        update_launch_session_data session[:launch_params]
      end
    end
end
