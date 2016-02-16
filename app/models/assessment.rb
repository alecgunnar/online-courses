class Assessment < ActiveRecord::Base
  has_many :submissions
  has_many :test_drivers
end
