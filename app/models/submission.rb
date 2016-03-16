class Submission < ActiveRecord::Base
  belongs_to :user
  belongs_to :assessment

  mount_uploader :file, SubmissionUploader

  validates :user, presence: true
  validates :assessment, presence: true
  validates :file, presence: true

  before_create :set_upload_date

  private
    def set_upload_date
      self.upload_date = Time.now
    end
end
