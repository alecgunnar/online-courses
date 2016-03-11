class TestDriverResult < ActiveRecord::Base
  belongs_to :submission
  belongs_to :test_driver

  has_many :test_driver_result_files, dependent: :destroy

  accepts_nested_attributes_for :test_driver_result_files

  validates :grade, presence: true, numericality: { greater_than_or_equal_to: 0 }

  validates_associated :test_driver_result_files

  def get_files (tdf)
    test_driver_result_files.find_by test_driver_file: tdf
  end
end
