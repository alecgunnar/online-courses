class User < ActiveRecord::Base
  has_many :submissions
  has_many :assessments, foreign_key: 'instructor_id'
  has_many :final_grades

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :org_id, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
