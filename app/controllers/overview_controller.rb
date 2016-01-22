class OverviewController < ApplicationController
	def index
		@data = get_org_info
	end

  def grade
    params = session['launch_params']
    provider      = IMS::LTI::ToolProvider.new(params['oauth_consumer_key'], Rails.configuration.lti['secret'], params)
    res           = provider.post_read_result!

    if res.success? and not res.score.nil?
      return redirect_to lti_error_path, alert: 'This assessment has already been scored.'
    end

    res = provider.post_replace_result! 0.5

    if res.success?
      redirect_to root_path
    else
      redirect_to lti_error_path, alert: 'Failed to submit the grade.'
    end
  end
end
