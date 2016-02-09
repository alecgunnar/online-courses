class Grade < ActiveRecord::Base
  belongs_to :user
  belongs_to :assessment
end
