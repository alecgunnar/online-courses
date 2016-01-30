class OverviewController < ApplicationController
	def index

	end

  def grade
    launch_params = @launch_params.dump
    provider      = IMS::LTI::ToolProvider.new(launch_params['oauth_consumer_key'], Rails.configuration.lti['secret'], launch_params)
    res           = provider.post_read_result!

    if res.success? and not res.score.nil?
      return redirect_to lti_error_path, alert: 'This assessment has already been scored.'
    end

    res = provider.post_replace_result! 1

    if res.success?
      redirect_to root_path
    else
      redirect_to lti_error_path, alert: 'Failed to submit the grade.'
    end
  end
end
