class Assessment < ActiveRecord::Base
  has_many :submissions
  has_many :test_drivers, dependent: :destroy

  belongs_to :instructor, class_name: 'User'

  mount_uploader :specs_file, SpecsUploader

  validates :specs_file, presence: true

  belongs_to :user

  def points
    pts = 0

    test_drivers.each do |td|
      pts += td.points

      td.test_driver_files.each do |tdf|
        pts += tdf.points
      end
    end

    pts
  end
end
