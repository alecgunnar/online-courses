require 'test_helper'

class OverviewControllerTest < ActionController::TestCase
  test 'boot without session' do
    get :index
    assert_redirected_to sign_in_path
  end
end
