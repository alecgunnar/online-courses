class TestDriverResult < ActiveRecord::Base
  belongs_to :submission
  belongs_to :test_driver
end
