class LaunchParams
  def initialize (l_params)
    @params = l_params
  end

  def full_name
    @params['lis_person_name_full']
  end

  def first_name
    @params['lis_person_name_given']
  end

  def context
    @params['context_title']
  end

  def dump
    @params
  end
end
