class TestDriver < ActiveRecord::Base
  belongs_to :assessment

  has_many :test_driver_files

  mount_uploader :file, TestDriverUploader

  validates :file, presence: true

  has_many :test_driver_files, dependent: :destroy
end
