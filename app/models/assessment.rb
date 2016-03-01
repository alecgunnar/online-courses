class Assessment < ActiveRecord::Base
  has_many :submissions
  has_many :test_drivers
  belongs_to :user, foreign_key: :instructor 
end
