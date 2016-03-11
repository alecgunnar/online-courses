class SubmissionsController < ApplicationController
  before_action :force_student
  before_action :force_configured, except: [:view]
  before_action :check_ownership, only: [:grade, :view, :download]
  before_action :status_checks, except: [:grade, :view, :download]

  def index
    @submission = Submission.new
  end

  def create
    @submission            = Submission.new submission_params
    @submission.assessment = @assessment
    @submission.user       = @launch_params.user

    @submission.save!

    redirect_to grade_path(@submission)
  end

  def grade
    @assessment.test_drivers.each do |t|
      worker = Grader::Worker.new
      result = TestDriverResult.new

      result.submission  = @submission
      result.test_driver = t

      worker.upload_files ["#{@submission.file.url}", "#{Rails.root}/spikes/#{t.name}"]
      result.output = worker.exec_cmd(['bash', t.name]).strip! || 'Execution Failed!'

      result.save!

      worker.close
    end

    redirect_to result_path(@submission)
  end

  def view
    @results = TestDriverResult.where submission: @submission
  end

  def download
    send_file @submission.file.url
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
        @message = t('submission.errors.not_configured')
        render 'general/error'
      end
    end

    def check_ownership
      @submission = Submission.find_by_id params[:id]

      if @submission.nil?
        not_found
      elsif @launch_params.user != @submission.user
        @message = t('errors.general.no_permission')
        return render 'general/error'
      end
    end

    def status_checks
      if Time.current >= @assessment.due_date
        @message = t('submission.errors.due_date_past')
        render 'general/error'
      end

      if @assessment.submit_limit > 0
        num_submissions = Submission.count assessment: @assessment, user: @launch_params.user

        if num_submissions >= @assessment.submit_limit
          @message = t('submission.errors.too_many_submissions')
          render 'general/error'
        end
      end
    end

    def submission_params
			params.require(:submission).permit(:file)
		end
end
