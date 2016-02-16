class DriverSubmissionFile < ActiveRecord::Base
  belongs_to :submission
  belongs_to :test_driver_file
end
