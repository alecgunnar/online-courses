class SubmissionsController < ApplicationController
  before_action :force_student
  before_action :force_configured

  def index
    @submission = Submission.new
  end

  def create
    @submission      = Submission.new submission_params
    @submission.user = @launch_params.user

    @submission.save!

    redirect_to grade_path @submission
  end

  def grade
    @submission = Submission.find params[:id]

    if @submission.nil?
      not_found
    elsif @launch_params.user != @submission.user
      @message = t('errors.general.no_permission')
      return render 'general/error'
    end

    worker              = Grader::Worker.new
    submission_uploader = SubmissionUploader.new

    worker.upload_files ["#{uploader.store_dir}/#{@submission.file}", "#{Rails.root}/spikes/driver.sh"]
    @output = worker.exec_cmd ['bash', 'driver.sh']
  end

  private
    def force_student
      if @launch_params.instructor?
        redirect_to launch_error_path, alert: t('errors.launch.not_permitted')
      end
    end

    def force_configured
      @assessment = Assessment.find_by context: @launch_params.context_id

      if @assessment.nil? 
        @message = t('errors.assessment.not_configured')
        render 'general/error'
      end
    end

    def submission_params
			params.require(:submission).permit(:file)
		end
end
