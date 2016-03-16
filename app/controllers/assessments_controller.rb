class AssessmentsController < ApplicationController
  before_action :load_assessment

  def index
    if @launch_params.instructor?
      @test_drivers = TestDriver.all
      puts @test_drivers
      render 'instructor'
    else
      if @assessment.new_record?
        @message = t('assessment.student.errors.not_configured')
        return render 'general/error'
      end

      @submissions = Submission.where user: @launch_params.user, assessment: @assessment

      render 'student'
    end
  end

  def new

  end

  def create
    @assessment.attributes = assessment_params
    @assessment.instructor = @launch_params.user
    @assessment.save!
    redirect_to root_path
  end

  def edit
    
  end

  def update
    @assessment.update! assessment_params
    redirect_to root_path
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

    def assessment_params
      params.require(:assessment).permit(:name, :submit_limit, :specs_file)
    end
end
