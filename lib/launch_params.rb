require 'ims/lti'

class LaunchParams
  include IMS::LTI::LaunchParams

  def initialize (params)
    process_params params
  end

  def instructor?
    if not @roles.nil? and not @roles.index('instructor').nil?
      return true
    end

    false
  end

  def first_name
    @lis_person_name_given
  end

  def user
    User.find_by org_id: self.user_id
  end
end
