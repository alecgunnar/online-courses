class TestDriverFile < ActiveRecord::Base
  belongs_to :test_driver

  mount_uploader :file, :TestDriverUploader

  validates :points, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
