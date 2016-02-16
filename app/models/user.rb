class User < ActiveRecord::Base
  has_many :submissions
end
