class FinalGrade < ActiveRecord::Base
  belongs_to :user
  belongs_to :assessment
  belongs_to :submission
end
