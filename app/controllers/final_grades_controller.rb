class FinalGradesController < ApplicationController
  before_action :force_instructor
  before_action :load_assessment

  def view
    @final_grades = FinalGrade.where assessment: @assessment
  end

  def export
    
  end

  private
    def load_assessment
      @assessment = Assessment.find_by params[:id]
      not_found if @assessment.nil?
    end
end
