class AssessmentsController < ApplicationController
  before_action :load_assessment

  def index
    @configured = (not @assessment.new_record?)

    if @session.instructor?
      if @configured
        @unreviewed_submissions = Submission.where(assessment: @assessment, grade_approved: false, graded: true)
        @reviewed_submissions   = Submission.where(assessment: @assessment, grade_approved: true)

        render 'instructor'
      else
        render 'not_configured'
      end
    else
      if not @configured or @assessment.test_drivers.length == 0
        @message = t('assessment.student.errors.not_configured')
        return render 'general/error'
      end

      @submissions = Submission.where user: @session.user, assessment: @assessment
      @final_grade = FinalGrade.find_by user: @session.user, assessment: @assessment

      render 'student'
    end
  end

  def specs
    assessment = Assessment.find params[:id]

    if not assessment.nil?
      return send_file assessment.specs_file.url
    end

    not_found
  end

  def new
    @assessment.test_drivers = [TestDriver.new]

    render 'form'
  end

  def create
    @assessment.attributes = assessment_params
    @assessment.assign_attributes({
      instructor: @session.user,
      consumer:   @session.consumer
    })

    if @assessment.valid?
      @assessment.save!
      @assessment.calculate_points

      return redirect_to root_path
    end

    render 'form'
  end

  def edit
    render 'form'
  end

  def update
    @assessment.attributes = assessment_params

    if @assessment.valid?
      @assessment.save!
      @assessment.calculate_points

      return redirect_to root_path
    end

    render 'form'
  end

  private
    def load_assessment
      @assessment         = Assessment.find_by(context: @session.launch_params.context_id) || Assessment.new
      @assessment.context = @session.launch_params.context_id if @assessment.context.nil?
    end

    def assessment_params
      params.require(:assessment).permit(:name, :description, :submit_limit, :specs_file, :due_date, :add_test_driver, test_drivers_attributes: [:id, :_destroy, :file, :points, :downloadable, test_driver_files_attributes: [:id, :_destroy, :name, :points]])
    end
end
