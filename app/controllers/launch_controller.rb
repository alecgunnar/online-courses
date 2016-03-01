class LaunchController < ApplicationController
  protect_from_forgery except: [:verify]
  skip_before_action :has_launched

  def verify
    provider = IMS::LTI::ToolProvider.new params['oauth_consumer_key'], Rails.configuration.lti['secret'], params

    if provider.valid_request? request
      redirect_to launch_error_path, alert: t('errors.launch.invalid_launch_params') and return if params[:context_id].nil?

      update_launch_session_data params
      persist_user_data

      redirect_user
    else
      redirect_to launch_error_path, alert: t('errors.launch.invalid_launch')
    end
  end

  def error
    flash.keep
  end

  private
    def persist_user_data
      return if params[:user_id].nil?

      user = User.exists?(org_id: params[:user_id]) ? @launch_params.user : User.new

      user.first_name = params[:lis_person_name_given]
      user.last_name  = params[:lis_person_name_family]
      user.email      = params[:lis_person_contact_email_primary]
      user.org_id     = params[:user_id]

      user.save!
    end
end
