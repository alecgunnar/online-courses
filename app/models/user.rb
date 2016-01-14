class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates :email, :format => {:with => /\A(.?)*@wmich.edu/, :message => "must be a Western Michigan University address."}

  def valid_api_token_data
    not (token_key.nil? or token_id.nil? or token_sig.nil?)
  end
end
