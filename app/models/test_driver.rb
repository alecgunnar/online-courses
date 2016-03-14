class TestDriver < ActiveRecord::Base
  belongs_to :assessment

  has_many :test_driver_files

  mount_uploader :file, TestDriverUploader

  validates :file, presence: true

  has_many :test_driver_files, dependent: :destroy

  validates :points, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
