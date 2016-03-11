class TestDriverResultFile < ActiveRecord::Base
  belongs_to :test_driver_result
  belongs_to :test_driver_file

  validates :grade, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
