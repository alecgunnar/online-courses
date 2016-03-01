class AssessmentController < ApplicationController
  before_action :force_instructor
  before_action :load_assessment

  def index
    
  end

  private
    def load_assessment
      @assessment         = Assessment.find_by(context: @launch_params.context_id) || Assessment.new
      @assessment.context = @launch_params.context_id if @assessment.context.nil?
    end

    def force_instructor
      if not @launch_params.instructor?
        redirect_to launch_error_path, alert: t('errors.launch.not_permitted')
      end
    end
end
