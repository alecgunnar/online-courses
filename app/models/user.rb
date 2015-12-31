class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates :email, :format => {:with => /\A(.?)*@wmich.edu/, :message => "must be a Western Michigan University address."}
end
