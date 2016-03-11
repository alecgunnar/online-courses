class TestDriverResultFile < ActiveRecord::Base
  belongs_to :test_driver_result
  belongs_to :test_driver_file
end
