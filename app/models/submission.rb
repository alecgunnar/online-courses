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
    TestDriverResult.select('SUM(test_driver_results.grade + IFNULL(test_driver_result_files.grade, 0)) as grade').joins('LEFT JOIN test_driver_result_files ON test_driver_result_files.test_driver_result_id = test_driver_results.id').where(submission: self)[0].grade
  end

  private
    def set_upload_date
      self.upload_date = Time.now
    end

    def remove_files
      FileUtils.rmtree File.dirname(file.url)
    end
end
