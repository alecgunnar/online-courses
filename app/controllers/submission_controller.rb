class SubmissionController < ApplicationController
  before_action :force_student

  def index
    @submissions = Submission.all
    @submission = Submission.new
  end

  def create
    @submission = Submission.new submission_params
    @submission.save
    redirect_to submission_index_path
  end

  def destroy
    @submission = Submission.first
    @submission.destroy
    redirect_to submission_index_path
  end

	private
    def force_student
      if @launch_params.instructor?
        redirect_to launch_error_path, alert: t('errors.launch.not_permitted')
      end
    end

    def submission_params
			params.require(:submission).permit(:name, :attachment)
		end
end
