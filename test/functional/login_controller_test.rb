require 'test_helper'

class LoginControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get request_reset" do
    get :request_reset
    assert_response :success
  end

  test "should get reset" do
    get :reset
    assert_response :success
  end

end
