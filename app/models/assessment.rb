class Assessment < ActiveRecord::Base
  has_many :submissions
  has_many :test_drivers, dependent: :destroy

  belongs_to :instructor, class_name: 'User'

  mount_uploader :specs_file, SpecsUploader

  validates :specs_file, presence: true

  belongs_to :user

  def points
    TestDriver.select('SUM(test_drivers.points + IFNULL(test_driver_files.points, 0)) as points').joins('LEFT JOIN test_driver_files ON test_driver_files.test_driver_id = test_drivers.id').where(assessment: self)[0].points || 0
  end
end
