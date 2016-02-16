class TestDriver < ActiveRecord::Base
  belongs_to :assessment
  has_many :test_driver_files
end
