class Consumer < ActiveRecord::Base
  has_many :assessments

  validates :key, presence: true
  validates :outcome_url, presence: true
end
