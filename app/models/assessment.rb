class Assessment < ActiveRecord::Base
  has_many :submissions
  has_many :test_drivers

  belongs_to :instructor, class_name: 'User'

  mount_uploader :specs_file, SpecsUploader

  validates :specs_file, presence: true
end
