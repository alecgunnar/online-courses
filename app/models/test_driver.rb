class TestDriver < ActiveRecord::Base
  belongs_to :assessment

  has_many :test_driver_files, dependent: :destroy
  has_many :test_driver_results, dependent: :destroy

  accepts_nested_attributes_for :test_driver_files, allow_destroy: true

  mount_uploader :file, TestDriverUploader

  validates :file, presence: true
  validates :points, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
