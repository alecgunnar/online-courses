class LaunchController < ApplicationController
  protect_from_forgery except: [:verify]
  skip_before_action :has_launched

  def verify
    @provider = IMS::LTI::ToolProvider.new params[:oauth_consumer_key], Rails.configuration.lti['secret'], params

    if @provider.valid_request? request
      redirect_to launch_error_path, alert: t('errors.launch.invalid_launch_params') and return if params[:context_id].nil?

      update_launch_session_data params

      persist_consumer_data

      redirect_to root_path if persist_user_data
    else
      redirect_to launch_error_path, alert: t('errors.launch.invalid_launch')
    end
  end

  def error
    flash.keep
    render 'general/error'
  end

  private
    def persist_user_data
      user = @session.user || User.new

      user.first_name = params[:lis_person_name_given]
      user.last_name  = params[:lis_person_name_family]
      user.email      = params[:lis_person_contact_email_primary]
      user.org_id     = @session.launch_params.org_def_id

      user.save!
    end

    def persist_consumer_data
      consumer = @session.consumer || Consumer.new

      consumer.assign_attributes({
        key:         params[:oauth_consumer_key],
        outcome_url: params[:lis_outcome_service_url]
      })

      consumer.save!
    end
end
