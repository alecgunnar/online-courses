class Assessment < ActiveRecord::Base
  has_many :submissions
  has_many :test_drivers, dependent: :destroy
  has_many :final_grades

  belongs_to :instructor, class_name: 'User', foreign_key: 'user_id'

  accepts_nested_attributes_for :test_drivers, allow_destroy: true

  mount_uploader :specs_file, SpecsUploader

  validates :name, presence: true
  validates :submit_limit, numericality: { greater_than_or_equal_to: 0 }
  validates :specs_file, presence: true
  validate :validate_due_date

  before_destroy :remove_files

  def points
    TestDriver.select('SUM(test_drivers.points + IFNULL(test_driver_files.points, 0)) as points').joins('LEFT JOIN test_driver_files ON test_driver_files.test_driver_id = test_drivers.id').where(assessment: self)[0].points || 0
  end

  private
    def validate_due_date
      errors.add('Due date', 'must be a future date.') unless (not due_date.nil?) and due_date > Time.current
    end

    def remove_files
      FileUtils.rmtree File.dirname(specs_file.url)
    end
end
