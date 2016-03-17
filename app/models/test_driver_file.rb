class TestDriverFile < ActiveRecord::Base
  belongs_to :test_driver

  has_many :test_driver_result_files, dependent: :destroy

  validates :name, presence: true
  validates :points, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
