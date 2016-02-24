class User < ActiveRecord::Base
  has_many :submissions

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :org_id, presence: true
end
