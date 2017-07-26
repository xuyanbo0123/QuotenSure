require 'test_helper'

class Lib::ZipCodeControllerTest < ActionController::TestCase
  test "should get get_city_state" do
    get :get_city_state
    assert_response :success
  end

end
