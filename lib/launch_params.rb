require 'ims/lti'

class LaunchParams
  include IMS::LTI::LaunchParams

  attr_accessor :org_def_id

  def initialize (params)
    self.org_def_id = params[Rails.configuration.lti['org_defined_id']]

    process_params params
  end

  def first_name
    @lis_person_name_given
  end
end
