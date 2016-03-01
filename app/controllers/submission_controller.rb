class SubmissionController < ApplicationController
  before_action :force_student

  def index
    
  end

  private
    def force_student
      if @launch_params.instructor?
        redirect_to launch_error_path, alert: t('errors.launch.not_permitted')
      end
    end
end
