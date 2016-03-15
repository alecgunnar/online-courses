class TestDriverFile < ActiveRecord::Base
  belongs_to :test_driver

  mount_uploader :file, :TestDriverUploader
end
