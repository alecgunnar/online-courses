class Session
  attr_accessor :launch_params

  def initialize (l_params)
    self.launch_params = l_params
  end

  def instructor?
    (not launch_params.roles.nil? and not launch_params.roles.index('instructor').nil?)
  end

  def user
    User.find_by org_id: launch_params.org_def_id
  end

  def consumer
    Consumer.find_by key: launch_params.oauth_consumer_key
  end
end
