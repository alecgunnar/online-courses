class AssessmentController < ApplicationController
  before_action :load_assessment

  def index
    if @launch_params.instructor?
      render 'instructor'
    else
      if @assessment.new_record?
        @message = t('errors.assessment.not_configured')
        return render 'general/error'
      end

      @submissions = Submission.where user: @launch_params.user, assessment: @assessment

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
