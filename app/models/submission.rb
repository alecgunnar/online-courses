class Submission < ActiveRecord::Base
  belongs_to :user
  belongs_to :assessment

  has_many :test_driver_results, dependent: :destroy

  accepts_nested_attributes_for :test_driver_results

  mount_uploader :file, SubmissionUploader

  validates :user, presence: true
  validates :assessment, presence: true
  validates :file, presence: true

  before_create :set_upload_date

  validates_associated :test_driver_results

  before_create :set_upload_date
  before_destroy :remove_files

  def grade
    pts = 0

    test_driver_results.each do |tdr|
      pts += tdr.grade || 0

      tdr.test_driver_result_files.each do |tdrf|
        pts += tdrf.grade || 0
      end
    end

    pts
  end

  private
    def set_upload_date
      self.upload_date = Time.now
    end

    def remove_files
      FileUtils.rmtree File.dirname(file.url)
    end
end
