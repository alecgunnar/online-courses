class AssessmentController < ApplicationController
  before_action :load_assessment

  def index
    @configured = (not @assessment.new_record?)

    if @launch_params.instructor?
      if @configured
        @unreviewed_submissions = Submission.where(assessment: @assessment, grade_approved: false, graded: true)
        @reviewed_submissions = Submission.where(assessment: @assessment, grade_approved: true)

        render 'instructor'
      else
        render 'not_configured'
      end
    else
      if not @configured or @assessment.test_drivers.length == 0
        @message = t('assessment.student.errors.not_configured')
        return render 'general/error'
      end

      @submissions = Submission.where user: @launch_params.user, assessment: @assessment
      @grade       = 0

      @submissions.each do |s|
        @grade = s.grade if s.grade_approved and s.grade > @grade
      end

      render 'student'
    end
  end

  def specs
    assessment = Assessment.find params[:id]

    if not assessment.nil?
      return send_file "#{Rails.root}/spikes/#{assessment.specs_file}"
    end

    not_found
  end

  private
    def load_assessment
      @assessment         = Assessment.find_by(context: @launch_params.context_id) || Assessment.new
      @assessment.context = @launch_params.context_id if @assessment.context.nil?
    end
end
