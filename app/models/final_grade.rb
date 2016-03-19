class FinalGrade < ActiveRecord::Base
  belongs_to :user
  belongs_to :assessment
  belongs_to :submission

  def decimal_result
    submission.grade.to_d / assessment.points.to_d
  end
end
