class LtiController < ApplicationController
  protect_from_forgery except: [:verify]
  skip_before_action :has_launched

  def verify
    provider = IMS::LTI::ToolProvider.new params['oauth_consumer_key'], Rails.configuration.lti['secret'], params

    if provider.valid_request? request
      if provider.outcome_service?
        session['launch_params'] = params
        
        lp = LaunchParams.new params
        
        if lp.instructor?
          redirect_to manage_path
        else
          redirect_to root_path
        end
      else
        redirect_to lti_error_path, alert: 'This application has not been configured for the assessment.'
      end
    else
      redirect_to lti_error_path, alert: 'We could not validate your request.'
    end
  end

  def error
    flash.keep
  end
end
